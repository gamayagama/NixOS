#!/bin/sh
pushd ~/.config/nixos
sudo nixos-rebuild switch --flake .#
popd
