{ config, ... }:

{
	programs.alacritty.enable = true;

  home.file.".config/alacritty".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/alacritty";
}
