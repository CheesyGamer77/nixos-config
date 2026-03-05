{ pkgs, ... }:

{
  home.packages = with pkgs; [
    eza
    bat
    fzf
    ripgrep
  ];

  programs.hyfetch.enable = true;
  
  programs.zsh = {
    enable = true;
    shellAliases = {
      ls = "eza";
      cat = "bat --paging=never";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "ssh"
        "ssh-agent"
        "gitignore"
      ];
      theme = "robbyrussell";
      extraConfig = "zstyle :omz:plugins:ssh-agent identities github";
    };
  };
}
