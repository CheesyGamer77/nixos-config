{ config, pkgs, ... }:

{
	programs.tmux = {
		enable = true;
		sensibleOnTop = true;

		plugins = with pkgs.tmuxPlugins; [
			yank
			vim-tmux-navigator
			tokyo-night-tmux
		];
	};

	# FIXME: Why does home.file not work here when it works everywhere else???
  xdg.configFile."tmux/tmux.conf".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/tmux/tmux.conf";
}
