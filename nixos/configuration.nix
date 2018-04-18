{ config, pkgs, lib, ... }:

let
  unstable = import <nixos-unstable> {
    config.allowUnfree = true;
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
  i18n.consoleFont = "Lat2-Terminus16";
  #i18n.consoleKeyMap = "fi";
  i18n.consoleUseXkbConfig = true;
  i18n.defaultLocale = "en_DK.UTF-8";

  time.timeZone = "Europe/Helsinki";

  hardware.pulseaudio.enable = true;

  sound.enable = true;
  sound.mediaKeys.enable = true;
  sound.mediaKeys.volumeStep = "1%";

  environment.systemPackages = with pkgs; [ 
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
  environment.variables = {
    EDITOR = "vim";
    BROWSER = "firefox";
  };
  environment.shells = [ (import ./elvish.nix) ];

  # nixpkgs.config = baseConfig // {
  #   packageOverrides = pkgs: {
  #     elvish = pkgs.elvish.overrideAttrs (old: {
  #       shellPath = "/bin/elvish";
  #     });
  #   };
  # };

  programs.bash.enableCompletion = true;
  programs.ssh.startAgent = true;

  services.compton.enable = true;

  services.xserver.enable = true;
  services.xserver.windowManager = {
    xmonad.enable = true;
    xmonad.enableContribAndExtras = true;
    xmonad.extraPackages = haskellPackages: [
      haskellPackages.xmobar
    ];
    default = "xmonad";
  };
  services.xserver.desktopManager = {
    default = "none";
    xterm.enable = false;
  };
  services.xserver.displayManager = {
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

  services.xserver.layout = "fi";
  services.xserver.xkbVariant = "nodeadkeys";
  services.xserver.videoDrivers = [ "nvidia" ];
  services.xserver.xautolock.enable = false;

  services.xserver.screenSection = ''
    Option "metamodes"                "nvidia-auto-select +0+0 {ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}"
    Option "AllowIndirectGLXProtocol" "off"
    Option "TripleBuffer"             "on"
  '';
  services.xserver.monitorSection = ''
    Option "DPMS" "false"
  '';
  services.xserver.serverLayoutSection = ''
    Option "StandbyTime" "0"
    Option "SuspendTime" "0"
    Option "OffTime"     "0"
    Option "BlankTime"   "0"
  '';

  #services.redshift = {
  #  enable = true;
  #  latitude = "60.1920";
  #  longitude = "24.9458";
  #};

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.ilmari = {
    shell = (import ./elvish.nix);
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
