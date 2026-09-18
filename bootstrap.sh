#!/usr/bin/env bash

set -euo pipefail

ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
TARGET_HOME="$HOME"

PROJECTOR_DIR="$ROOT/repos/rofl-projector"
PROJECTOR_VENV="$PROJECTOR_DIR/.venv"

# -----------------------------------------------------------------------------
# Helpers
# -----------------------------------------------------------------------------

log() {
    printf '\n\033[1;35m==>\033[0m %s\n' "$*"
}

warn() {
    printf '\n\033[1;33mWARN:\033[0m %s\n' "$*" >&2
}

die() {
    printf '\n\033[1;31mERROR:\033[0m %s\n' "$*" >&2
    exit 1
}


# -----------------------------------------------------------------------------
# Preconditions
# -----------------------------------------------------------------------------

require_arch() {
    [[ -f /etc/arch-release ]] ||
        die "This bootstrapper is intended for Arch Linux."
}

require_user() {
    [[ "$EUID" -ne 0 ]] ||
        die "Run bootstrap as your normal user, not root."
}

require_repo() {
    [[ -f "$ROOT/packages-framework.txt" ]] ||
        die "packages-framework.txt not found."

    [[ -d "$ROOT/.git" ]] ||
        die "Bootstrap must run from the dotfiles Git repository."
}


# -----------------------------------------------------------------------------
# Pacman
# -----------------------------------------------------------------------------

ensure_multilib() {
    if grep -q '^\[multilib\]$' /etc/pacman.conf; then
        log "multilib already enabled"
        return
    fi

    log "Enabling multilib"

    sudo sed -i \
        -e 's/^#\[multilib\]$/[multilib]/' \
        -e '/^\[multilib\]$/ {
            n
            s|^#Include = /etc/pacman.d/mirrorlist$|Include = /etc/pacman.d/mirrorlist|
        }' \
        /etc/pacman.conf
}

install_packages() {
    log "Installing system packages"

    mapfile -t packages < <(
        grep -Ev '^[[:space:]]*(#|$)' \
            "$ROOT/packages-framework.txt"
    )

    sudo pacman -Syu --needed "${packages[@]}"
}


# -----------------------------------------------------------------------------
# Git
# -----------------------------------------------------------------------------

init_submodules() {
    log "Initialising Git submodules"

    git -C "$ROOT" submodule update --init --recursive
}

# -----------------------------------------------------------------------------
# Socket Firewall - MASON
# -----------------------------------------------------------------------------

install_socket_firewall() {
    if command -v sfw >/dev/null 2>&1; then
        return
    fi

    log "Installing Socket Firewall Free"

    curl -L -o /tmp/sfw \
        https://github.com/SocketDev/sfw-free/releases/latest/download/sfw-free-linux-x86_64

    chmod +x /tmp/sfw
    sudo install -m755 /tmp/sfw /usr/local/bin/sfw
    rm -f /tmp/sfw
}

# -----------------------------------------------------------------------------
# GNU Stow
# -----------------------------------------------------------------------------

stow_from() {
    local directory="$1"
    shift

    stow \
        --dir="$ROOT/$directory" \
        --target="$TARGET_HOME" \
        --restow \
        "$@"
}

stow_dotfiles() {
    log "Stowing ~/.config packages"

    stow_from config \
        hypr \
        kitty \
        projector \
        rofi \
        waybar

    log "Stowing ~/.local packages"

    stow_from local \
        ytm

    log "Stowing shell configuration"

    stow_from shell \
        git \
        zsh

    log "Stowing Neovim"

    stow \
        --dir="$ROOT" \
        --target="$TARGET_HOME" \
        --restow \
        nvim
}


# -----------------------------------------------------------------------------
# Application state
# -----------------------------------------------------------------------------

create_runtime_state() {
    log "Creating runtime state"

    mkdir -p "$HOME/.config/todos"

    touch \
        "$HOME/.config/todos/todo" \
        "$HOME/.config/todos/complete"

    mkdir -p "$HOME/.local/bin"
}


# -----------------------------------------------------------------------------
# Projector / Todos / Python
# -----------------------------------------------------------------------------

install_python_repo() {
    local repo_name="$1"
    local command_name="$2"

    local repo_dir="$ROOT/repos/$repo_name"
    local venv_dir="$repo_dir/.venv"

    log "Installing $repo_name"

    [[ -f "$repo_dir/pyproject.toml" ]] ||
        die "$repo_name submodule is missing or invalid."

    if [[ ! -d "$venv_dir" ]]; then
        python -m venv "$venv_dir"
    fi

    "$venv_dir/bin/python" \
        -m pip install --upgrade pip

    "$venv_dir/bin/python" \
        -m pip install -e "$repo_dir"

    [[ -x "$venv_dir/bin/$command_name" ]] ||
        die "$command_name console entry point was not created."

    mkdir -p "$HOME/.local/bin"

    ln -sfn \
        "$venv_dir/bin/$command_name" \
        "$HOME/.local/bin/$command_name"
}


# -----------------------------------------------------------------------------
# /etc configuration
# -----------------------------------------------------------------------------

install_system_configs() {
    log "Installing keyd configuration"

    sudo install -Dm644 \
        "$ROOT/system/keyd/system/keyd/default.conf" \
        /etc/keyd/default.conf

    sudo systemctl restart keyd.service

    log "Installing greetd configuration"

    sudo install -Dm644 \
        "$ROOT/system/greetd/system/greetd/config.toml" \
        /etc/greetd/config.toml
    
    log "Installing zram configuration"

    sudo install -Dm644 \
        "$ROOT/system/zram/zram-generator.conf" \
        /etc/systemd/zram-generator.conf
}


# -----------------------------------------------------------------------------
# Snapper
# -----------------------------------------------------------------------------

snapper_config_exists() {
    local name="$1"

    sudo snapper list-configs 2>/dev/null |
        awk 'NR > 2 { print $1 }' |
        grep -qx "$name"
}

prepare_snapper_config() {
    local name="$1"
    local path="$2"

    if snapper_config_exists "$name"; then
        return
    fi

    log "Creating Snapper config: $name"

    if ! sudo snapper -c "$name" create-config "$path"; then
        warn "Snapper could not create '$name' automatically."
        warn "The Btrfs .snapshots subvolume may already exist."
        warn "Installing the saved config anyway."
    fi
}

configure_snapper() {
    log "Configuring Snapper"

    prepare_snapper_config root /
    prepare_snapper_config home /home

    sudo install -Dm640 \
        "$ROOT/system/snapper/configs/root" \
        /etc/snapper/configs/root

    sudo install -Dm640 \
        "$ROOT/system/snapper/configs/home" \
        /etc/snapper/configs/home

    sudo systemctl enable --now \
        snapper-cleanup.timer \
        snapper-timeline.timer
}


# ----------------------------------------------------------------------------- 
# Firefox / YouTube Music profile
# -----------------------------------------------------------------------------

find_firefox_ytm_profile() {
    python - <<'PY'
import configparser
from pathlib import Path

root = Path.home() / ".mozilla" / "firefox"
ini = root / "profiles.ini"

if not ini.exists():
    raise SystemExit(1)

config = configparser.ConfigParser()
config.read(ini)

for section in config.sections():
    if not section.startswith("Profile"):
        continue

    if config[section].get("Name") != "ytm":
        continue

    path = Path(config[section]["Path"])

    if config[section].getboolean("IsRelative", fallback=True):
        path = root / path

    print(path)
    raise SystemExit(0)

raise SystemExit(1)
PY
}

configure_firefox_ytm() {
    local profile=""

    log "Configuring Firefox YTM profile"

    profile="$(find_firefox_ytm_profile || true)"

    if [[ -z "$profile" ]]; then
        log "Creating Firefox profile 'ytm'"

        firefox --headless -CreateProfile ytm

        profile="$(find_firefox_ytm_profile || true)"
    fi

    if [[ -z "$profile" ]]; then
        warn "Could not locate Firefox YTM profile."
        warn "Skipping userChrome.css."
        return
    fi

    mkdir -p "$profile/chrome"

    install -m644 \
        "$ROOT/firefox-ytm/chrome/userChrome.css" \
        "$profile/chrome/userChrome.css"

    log "Installed YTM Firefox chrome at: $profile"
}


# -----------------------------------------------------------------------------
# Shell
# -----------------------------------------------------------------------------

set_default_shell() {
    local zsh_path
    local current_shell

    zsh_path="$(command -v zsh)"
    current_shell="$(getent passwd "$USER" | cut -d: -f7)"

    if [[ "$current_shell" == "$zsh_path" ]]; then
        log "Zsh is already the login shell"
        return
    fi

    log "Setting Zsh as login shell"

    chsh -s "$zsh_path"
}


# -----------------------------------------------------------------------------
# Services
# -----------------------------------------------------------------------------

enable_system_services() {
    log "Enabling system services"

    sudo systemctl enable --now \
        NetworkManager.service \
        bluetooth.service \
        keyd.service \
        mullvad-daemon.service \
        power-profiles-daemon.service \
        fstrim.timer

    # Do not replace the current login session underneath the bootstrap.
    sudo systemctl enable greetd.service
}

enable_user_services() {
    log "Enabling user services"

    systemctl --user enable \
        hyprpolkitagent.service
}


# -----------------------------------------------------------------------------
# Finish
# -----------------------------------------------------------------------------

print_manual_steps() {
    cat <<'EOF'

Bootstrap complete.

Manual account/authentication steps:
  • gh auth login
  • configure/generate SSH keys
  • log into Mullvad
  • log into Firefox / YouTube Music
  • log into Steam

Still intentionally deferred until the Framework:
  • persistent swap + hibernation/resume
  • TPM2 LUKS enrolment
  • Secure Boot
  • fingerprint setup
  • Framework-specific power tuning
  • final hwmon/temperature configuration

Recommended:
  reboot
EOF
}


main() {
    require_arch
    require_user
    require_repo

    sudo -v

    ensure_multilib
    install_packages

    init_submodules

    create_runtime_state
    stow_dotfiles

    install_socket_firewall

    install_python_repo "rofl-projector" "projector"
    install_python_repo "rofl-todo" "todos" 

    install_system_configs
    configure_snapper
    configure_firefox_ytm

    set_default_shell

    enable_system_services
    enable_user_services

    print_manual_steps
}

main "$@"
