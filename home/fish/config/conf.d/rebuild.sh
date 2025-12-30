#!/usr/bin/env bash
FLAKE_PATH="$HOME/nixos_config"
doas env GIT_ALLOW_ROOT=1 nixos-rebuild switch --flake path:"$FLAKE_PATH#$HOSTNAME"
