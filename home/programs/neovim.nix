{ config, lib, pkgs, ... }:

{
  home.file.".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/nvim";

  programs.neovim = {
    enable = true;
    package = pkgs.neovim;
    vimAlias = true;
    coc.enable = false;
    withNodeJs = true;
	extraPackages = with pkgs; [
	  lua-language-server
	  nixd
	];
  };
}
