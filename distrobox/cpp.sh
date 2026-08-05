#!/bin/bash

set -e

sudo sed -i 's/^NoExtract.*man/# &/' /etc/pacman.conf

sudo pacman -Syu --noconfirm

sudo pacman -S --noconfirm --needed \
  base-devel \
  bat \
  bear \
  btop \
  clang \
  curl \
  debuginfod \
  eza \
  fzf \
  gcc \
  gdb \
  git \
  lazygit \
  libbsd \
  libx11 \
  libxext \
  lldb \
  make \
  man-db \
  man-pages \
  nasm neovim \
  openssh \
  openssl \
  php-cgi \
  readline \
  siege \
  strace \
  tree-sitter-cli \
  unzip \
  unrar \
  valgrind \
  wl-clipboard \
  zsh

sudo pacman -U --noconfirm ~/Work/dev_containers/cpp/files/norminette-3.3.55-1-x86_64.pkg.tar.zst

sudo mkdir -p /usr/local/lib /usr/local/include/ /usr/local/man/man3
sudo cp ~/Work/dev_containers/cpp/files/mlx/libmlx.a /usr/local/lib
sudo cp ~/Work/dev_containers/cpp/files/mlx/mlx.h /usr/local/include
sudo cp ~/Work/dev_containers/cpp/files/mlx/man3/* /usr/local/man/man3/

sudo mandb
