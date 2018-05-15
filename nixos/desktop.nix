{ lib, ... }:

{
  fileSystems."/home" = {
    # /dev/sdc1
    device = "/dev/disk/by-uuid/d49f25dd-cb21-4cca-aa93-8dd38b0d91e5";
    fsType = "ext4";
  };

  boot.loader.efi.canTouchEfiVariables = true;

  boot.loader.grub.devices = [ "nodev" ];
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.extraEntries = ''
    menuentry "Windows" {
      insmod part_gpt
      insmod fat
      insmod search_fs_uuid
      insmod chain
      search --fs--uid --set=root fe505ac3-54aa-4605-9baa-40bb62f0d7ec
      chainloader /EFI/Microsoft/Boot/bootmgfw.efi
    }
  '';

}
