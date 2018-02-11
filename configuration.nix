# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  #boot.loader.grub = {
  #  enable = true;
  #  version = 2;
  #  efiSupport = true;
  #  device = "nodev";
  #};

  powerManagement.cpuFreqGovernor = pkgs.lib.mkForce "performance";

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
  ];

  environment.variables = {
    EDITOR = "vim";
    BROWSER = "firefox";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.bash.enableCompletion = true;
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable the X11 windowing system.
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
