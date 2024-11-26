{
  inputs = {
    nixpkgs = {url = "github:nixos/nixpkgs/nixos-24.11";};
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    alejandra = {
      url = "github:kamadorueda/alejandra";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    alejandra,
    ...
  } @ inputs: let
    pkgs = import nixpkgs {
      system = "x86_64-linux";
      config = {allowUnfree = true;};
    };

    mkHost = hostname: system: username: fullName:
      nixpkgs.lib.nixosSystem {
        system = system;
        specialArgs = {inherit pkgs inputs system hostname username fullName;};
        modules = [
          {environment.systemPackages = [alejandra.defaultPackage.${system}];}
          {networking.hostName = hostname;}
          ./hosts/${hostname}
          ./modules/nixos/users
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs pkgs username; };
            home-manager.users.${username} = import ./users/${username};
          }
        ];
      };
  in {
    # overlays.default = final: prev: {};
    # devShells.${system}.default = {};

    nixosConfigurations = {
      # host         host    system         user   fullName
      nyx = mkHost "nyx" "x86_64-linux" "gama" "Gamayun Robakov";
      lethe = mkHost "lethe" "x86_64-linux" "gama" "Gamayun Robakov";
    };
  };
}
