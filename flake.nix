{
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    nixpkgs-stable = {
      url = "github:nixos/nixpkgs/nixos-24.11";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
    };
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    zen-browser = {
      url = "github:MarceColl/zen-browser-flake";
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

      pkgs-stable = import inputs.nixpkgs-stable {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };

      mkHost =
        hostname: system: username: fullName:
        nixpkgs.lib.nixosSystem {
          inherit pkgs system;
          specialArgs = {
            inherit
              inputs
              system
              hostname
              username
              fullName
              ;
          };
          modules = [
            # { environment.systemPackages = [ inputs.alejandra.defaultPackage.${system} ]; }
            { networking.hostName = hostname; }
            ./hosts/${hostname}
            ./modules/nixos/users
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = {
                  inherit
                    inputs
                    pkgs
                    pkgs-stable
                    username
                    ;
                };
                users.${username} = import ./users/${username};
              };
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
