#!/bin/sh
pushd ~/.config/nixos
nix build .#homeConfigurations.gama.activationPackage
./result/activate
rm -rf result
popd
