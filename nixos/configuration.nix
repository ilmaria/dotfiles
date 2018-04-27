{ config, pkgs, lib, ... }:

let 
  baseConfig = {
    allowUnfree = true;
  };
  unstable = import <nixos-unstable> {
    # Pass the nixpkgs config to the unstable alias
    # to ensure `allowUnfree = true;` is propagated:
    config = baseConfig;
  };
in {
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.useOSProber = true;

  powerManagement.cpuFreqGovernor = lib.mkForce "performance";

  networking.hostName = "ilmari-nixos";

  nixpkgs.config.allowUnfree = true;

  system.autoUpgrade.enable = true;

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    # consoleKeyMap = "fi";
    consoleUseXkbConfig = true;
    defaultLocale = "en_DK.UTF-8";
  };

  time.timeZone = "Europe/Helsinki";

  hardware.pulseaudio.enable = true;

  sound = {
    enable = true;
    mediaKeys.enable = true;
    mediaKeys.volumeStep = "1%";
  };

  environment = with pkgs; {
    systemPackages = [ 
      (import ./elvish.nix)
      chromium
      curl
      dmenu
      exa
      feh
      firefox
      git
      haskellPackages.xmobar
      keepass
      libnotify
      notify-osd
      ripgrep
      rxvt_unicode
      unstable.stack
      vim_configurable  # vim with cliboard support (also depends on X11)
      vlc
      vscode
      wget
      xlibs.xmessage    # This is needed for xmobar
      xlibs.xset
    ];
    variables = {
      EDITOR = "vim";
      BROWSER = "firefox";
    };
  };

  # nixpkgs.config = baseConfig // {
  #   packageOverrides = pkgs: {
  #     elvish = pkgs.elvish.overrideAttrs (old: {
  #       shellPath = "/bin/elvish";
  #     });
  #   };
  # };

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
      slim.extraConfig = "numlock  on";
      sessionCommands = ''
        # Set keyboard repeat rate
        ${pkgs.xlibs.xset}/bin/xset r rate 190 30
        # Set mouse speed to 1
        ${pkgs.xlibs.xset}/bin/xset m 1
        # Select  wallpaper
        ${pkgs.feh}/bin/feh --no-fehbg --bg-scale ~/wallpapers/current.* &
      '';
    };

    layout = "fi";
    xkbVariant = "nodeadkeys";
    videoDrivers = [ "nvidia" ];
    xautolock.enable = false;
 
    screenSection = ''
      Option "metamodes"                "nvidia-auto-select +0+0 {ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}"
      Option "AllowIndirectGLXProtocol" "off"
      Option "TripleBuffer"             "on"
    '';

    monitorSection = ''
      Option "DPMS" "false"
    '';

    serverLayoutSection = ''
      Option "StandbyTime" "0"
      Option "SuspendTime" "0"
      Option "OffTime"     "0"
      Option "BlankTime"   "0"
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