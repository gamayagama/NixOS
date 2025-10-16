{
  inputs = {
    nixpkgs = {
      url = "https://flakehub.com/f/NixOS/nixpkgs/0.1";
    };
    home-manager = {
      url = "https://flakehub.com/f/nix-community/home-manager/0.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    determinate = {
      url = "https://flakehub.com/f/DeterminateSystems/determinate/*";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
    };
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
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
            inputs.determinate.nixosModules.default
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = {
                  inherit
                    inputs
                    pkgs
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
