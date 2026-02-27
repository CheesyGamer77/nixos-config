{ pkgs, ... }:

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

  users.users.casey = {
    isNormalUser = true;
    description = "CaseyCodes";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      
    ];
  };

  environment.systemPackages = with pkgs; [
    wget
    btop
    curl
    firefox
    discord
  ];

  system.stateVersion = "25.11"; # No touch :)
}
