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

  saphyr = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit inputs; };
    modules = [
      ./saphyr
      ./modules/common
    ];
  };
}
