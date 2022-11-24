{
  description = "Nixos system config by fmrh";

  inputs = {
    nixpkgs = { url = "github:nixos/nixpkgs/nixos-unstable"; };
    home-manager = { url = "github:nix-community/home-manager"; inputs.nixpkgs.follows = "nixpkgs"; };
    nur = { url = "github:nix-community/NUR"; inputs.nixpkgs.follows = "nixpkgs"; };
  };

  outputs =
  { self
  , nixpkgs
  , home-manager
  , nur
  , ... } @ inputs:

    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
      };
      lib = nixpkgs.lib;

    in {
      nixosConfigurations = (
        import ./hosts {
          inherit lib system pkgs inputs;
	      }
      );
      homeConfigurations = (
        import ./users {
         inherit lib system pkgs nur home-manager;
        }
      );
    };

}
