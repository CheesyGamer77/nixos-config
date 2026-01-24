{
  description = "I use NixOS, btw";

  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    nixos.url = "nixpkgs/nixos-unstable";
  };

  outputs = { nixpkgs, nixos, ... } @ inputs:
    let
      config = { allowUnfree = true; };

      nixosPkgs = import nixos {
        system = "x86_64-linux";
        inherit config;
      };

      x86Pkgs = import nixpkgs {
        system = "x86_64-linux";
        inherit config;
      };
    in {
      nixosConfigurations = {
        nixos-xps17 = nixos.lib.nixosSystem {
          system = "x86_64-linux";
          pkgs = nixosPkgs;
          modules = [
            ./nixos/xps17.nix
          ];
        };
      };
    };
}
