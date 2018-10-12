{ lib, pkgs, ... }:

{
  boot.loader.efi.canTouchEfiVariables = true;

  boot.loader.grub.devices = [ "nodev" ];
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;

  networking.networkmanager.enable = true;

  hardware.bluetooth.enable = true;

  environment.systemPackages = with pkgs; [ 
    networkmanager
  ]; 

  # Enable touchpad support.
  services.xserver.libinput.enable = true;
  services.xserver.libinput.clickMethod = "clickfinger";
  services.xserver.libinput.additionalOptions = ''
    Option "TappingButtonMap" "lmr"
  '';

  services.xserver.dpi = 115;
}
