{ config, pkgs, ... }:

{
	wayland.windowManager.hyprland = {
		enable = true;
	};

	home.file.".config/hypr".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/hypr";
}
