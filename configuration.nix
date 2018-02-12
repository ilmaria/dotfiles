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

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "fi";
    defaultLocale = "en_DK.UTF-8";
  };

  time.timeZone = "Europe/Helsinki";

  hardware.pulseaudio.enable = true;

  sound = {
    enable = true;
    mediaKeys.enable = true;
    mediaKeys.volumeStep = "1%";
  };

  environment.systemPackages = with pkgs; [
    wget
    curl
    vim_configurable  # vim with cliboard support (also depends on X11)
    git
    firefox
    rxvt_unicode
    keepass
    elvish
    chromium
    dmenu
    xlibs.xmessage    # This is needed for xmobar
    ripgrep
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
      xmonad.enableContribAndExtras = true;
      xmonad.extraPackages = haskellPackages: [
        haskellPackages.xmobar
      ];
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
    xautolock.enable = false;
 
    config = ''
      Section "Screen"
          Identifier "Screen0"
          Option     "metamodes" "nvidia-auto-select +0+0 {ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}"
          Option     "AllowIndirectGLXProtocol" "off"
          Option     "TripleBuffer" "on"
      EndSection

      Section "Monitor"
          Identifier "LVDS0"
          Option     "DPMS" "false"
      EndSection

      Section "ServerLayout"
          Identifier "ServerLayout0"
          Option     "StandbyTime" "0"
          Option     "SuspendTime" "0"
          Option     "OffTime"     "0"
          Option     "BlankTime"   "0"
      EndSection
    '';
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
