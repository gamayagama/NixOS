{
  inputs = {
    nixpkgs = {url = "github:nixos/nixpkgs/nixos-unstable";};
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {url = "github:hyprwm/Hyprland";};
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };

      mkHost =
        hostname: system: username: fullName:
        nixpkgs.lib.nixosSystem {
          inherit pkgs system;
          specialArgs = { inherit inputs system hostname username fullName; };
          modules = [
            # { environment.systemPackages = [ inputs.alejandra.defaultPackage.${system} ]; }
            { networking.hostName = hostname; }
            ./hosts/${hostname}
            ./modules/nixos/users
            home-manager.nixosModules.home-manager
            inputs.stylix.nixosModules.stylix
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs pkgs username; };
              home-manager.users.${username} = import ./users/${username};
            }
          ];
        };
    in
    {
      # formatter.${system} = inputs.alejandra.defaultPackage.${system};
      # overlays.default = final: prev: {};
      # devShells.${system}.default = {};

      nixosConfigurations = {
        # hostname = "host" "system" "user" "fullName"
        nyx = mkHost "nyx" "x86_64-linux" "gama" "Gamayun Robakov";
        lethe = mkHost "lethe" "x86_64-linux" "gama" "Gamayun Robakov";
      };
    };
}
