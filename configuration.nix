# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  powerManagement.cpuFreqGovernor = lib.mkForce "performance";

  nixpkgs.config.allowUnfree = true;

  networking.hostName = "ilmari-nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "fi";
    defaultLocale = "en_DK.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Europe/Helsinki";

  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    wget
    curl
    vim
    git
    firefox
    rxvt_unicode
  ];

  environment.variables = {
    EDITOR = "vim";
    BROWSER = "firefox";
  };

  programs.bash.enableCompletion = true;
  programs.ssh.startAgent = true;

  services.xserver = {
    enable = true;

    windowManager = {
      xmonad.enable = true;
      default = "xmonad";
    };

    desktopManager = {
      default = "none";
      xterm.enable = false;
    };
    
    displayManager = {
      slim.enable = true;
      slim.defaultUser = "ilmari";
      slim.autoLogin = true;
    };

    layout = "fi";
    videoDrivers = [ "nvidia" ];
  };


  #services.redshift = {
  #  enable = true;
  #  latitude = "60.1920";
  #  longitude = "24.9458";
  #};

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.ilmari = {
    isNormalUser = true;
    createHome = true;
    home = "/home/ilmari";
    extraGroups = [ "wheel" "audio" "networkmanager" ];
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "17.09"; # Did you read the comment?
}
