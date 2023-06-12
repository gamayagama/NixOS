{ lib, pkgs, inputs, system, ... }:

{
  terra = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit inputs; };
    modules = [
      ./terra
      ./modules/common

      ./modules/optional/gaming
    ];
  };

  athena = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit inputs; };
    modules = [
      ./athena
      ./modules/common
    ];
  };
}
