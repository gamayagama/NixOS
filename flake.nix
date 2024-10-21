{
  inputs = {
    nixpkgs = { url = "github:nixos/nixpkgs/nixos-unstable"; };
    home-manager = { url = "github:nix-community/home-manager"; inputs.nixpkgs.follows = "nixpkgs"; };
    hyprland = { url = "github:hyprwm/Hyprland"; };
  };

  outputs =
  { self
  , nixpkgs
  , home-manager
  , ... } @ inputs:

  let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
      config = { allowUnfree = true; }; 
    };

    mkHost = hostname: system: username: fullName:
      nixpkgs.lib.nixosSystem {
        system = system;
        specialArgs = { inherit inputs system hostname username fullName; };
        modules = [
          { networking.hostName = hostname; }
          ./hosts/${hostname}
          ./modules/nixos/users
        ];
      };
    
    mkHome = username:
      home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit inputs pkgs username; };
        modules = [
          ./users/${username}
        ];
      };

  in {
    # overlays.default = final: prev: {};
    # devShells.${system}.default = {};

    nixosConfigurations = {
    # host         host  system         user   fullName
      nyx = mkHost "nyx" "x86_64-linux" "gama" "Gamayun Robakov";
    };

    homeConfigurations = {
    # user          user
      gama = mkHome "gama";
    };
  };
}
