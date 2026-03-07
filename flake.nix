{
  description = "I use NixOS, btw";

  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    nixos.url = "nixpkgs/nixos-unstable";

    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/master";

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = { nixpkgs, nixos, home-manager, ... } @ inputs:
    let
      overlays = [ inputs.neovim-nightly-overlay.overlays.default ];

      config = { allowUnfree = true; };

      nixosPkgs = import nixos {
        system = "x86_64-linux";
        inherit config overlays;
      };

      x86Pkgs = import nixpkgs {
        system = "x86_64-linux";
        inherit config overlays;
      };
    in {
      nixosConfigurations = {
        nixos-xps17 = nixos.lib.nixosSystem {
          system = "x86_64-linux";
          pkgs = nixosPkgs;
          modules = [
            ./nixos/xps17.nix
            home-manager.nixosModules.home-manager {
              home-manager = {
                extraSpecialArgs = { pkgs = x86Pkgs; };
                users.casey = import ./home/users/casey/casey_xps17.nix;
                backupFileExtension = "backup";
              };
            }
          ];
        };
      };
    };
}
