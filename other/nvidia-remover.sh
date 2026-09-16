#!usr/bin/env bash

sudo pacman -Rns \
  nvidia-open \
  nvidia-utils \
  lib32-nvidia-utils \
  egl-gbm \
  egl-wayland \
  egl-wayland2 \
  egl-x11 \
  libvdpau
