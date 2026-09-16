#!/usr/bin/env bash
{
    echo '===== REPO TREE ====='
    find . \
        -maxdepth 6 \
        -not -path './.git/*' \
        -not -path '*/.venv/*' \
        -not -path '*/__pycache__/*' \
        -printf '%y %p -> %l\n' \
        | sort

    echo
    echo '===== GIT SUBMODULES ====='
    git submodule status 2>&1

    echo
    echo '===== OFFICIAL PACKAGES ====='
    cat packages-official.txt 2>/dev/null || pacman -Qqen

    echo
    echo '===== FOREIGN / AUR PACKAGES ====='
    cat packages-foreign.txt 2>/dev/null || pacman -Qqem

    echo
    echo '===== ENABLED SYSTEM UNITS ====='
    systemctl list-unit-files --state=enabled --no-pager

    echo
    echo '===== ENABLED USER UNITS ====='
    systemctl --user list-unit-files --state=enabled --no-pager

    echo
    echo '===== DEFAULT SHELL ====='
    getent passwd "$USER" | cut -d: -f7

    echo
    echo '===== MULTILIB ====='
    grep -A1 -n '^\[multilib\]' /etc/pacman.conf 2>/dev/null

    echo
    echo '===== STOW ====='
    command -v stow
    stow --version 2>/dev/null | head -n1

} > bootstrap-inventory.txt
