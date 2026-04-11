{ ... }:

{
  programs.home-manager.enable = true;
  
  home.username = "casey";
  home.homeDirectory = "/home/casey";

  home.packages = [ ];

  imports = [
    ../../programs/alacritty.nix
		../../programs/git.nix
    ../../programs/zsh.nix
    ../../programs/neovim.nix
		../../programs/tmux.nix
  ];

  home.stateVersion = "25.11"; # No touch :)
}
