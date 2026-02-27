{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;
  
  home.username = "casey";
  home.homeDirectory = "/home/casey";

  home.packages = [ ];

  imports = [
    ../../programs/git.nix
  ];

  home.stateVersion = "25.11"; # No touch :)
}
