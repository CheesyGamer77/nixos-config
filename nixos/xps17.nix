{ pkgs, config, ... }:

{
  imports = [
    ./hardware/xps17.nix
  ];

  nix = {
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 7d";
    };

    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
    };
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos-xps17";
  networking.networkmanager.enable = true;
  services.tailscale.enable = true;

  networking.firewall = {
	enable = true;
	trustedInterfaces = [ "tailscale0" ];
	allowedTCPPorts = [
	  57621  # Spotify local track sync
	];
	allowedUDPPorts = [
	  5353  # Spotify connect device discovery
	  config.services.tailscale.port  # Tailscale UDP
	];
  };
 
  # Force tailscale to use nftables (recommended for modern setups)
  systemd.services.tailscaled.serviceConfig.Environment = [
    "TS_DEBUG_FIREWALL_MODE=nftables"
  ];

  # Prevent systemd from waiting for network online (faster boot with VPNs)
  systemd.network.wait-online.enable = false;
  boot.initrd.systemd.network.wait-online.enable = false;

  time.hardwareClockInLocalTime = true;
  time.timeZone = "America/Detroit";

  services.xserver = {
    enable = true;
    autoRepeatDelay = 200;
    autoRepeatInterval = 35;
    #dpi = 266; # Don't need?
  };

  services.desktopManager.gnome.enable = true;
  services.displayManager.gdm.enable = true;

  services.printing.enable = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  programs.zsh.enable = true;

  fonts.packages = with pkgs; [
	nerd-fonts.jetbrains-mono
  ];

  fonts.fontconfig.enable = true;

  users.users.casey = {
    isNormalUser = true;
    description = "CaseyCodes";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" ];
  };

  environment.systemPackages = with pkgs; [
    wget
    btop
    curl
    firefox
    discord
    spotify
    libreoffice-fresh
    hunspell
    hunspellDicts.en_US
  ];

  system.stateVersion = "25.11"; # No touch :)
}
