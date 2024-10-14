#!/bin/sh
pushd ~/.config/nixos
nix flake update
popd
