{ lib, ... }:

{
  fileSystems."/home" = {
    # /dev/sdc1
    device = "/dev/disk/by-uuid/d49f25dd-cb21-4cca-aa93-8dd38b0d91e5";
    fsType = "ext4";
  };

  
  services.xserver.displayManager.sessionCommands = lib.mkForce ''
    # Workaround to enable elvish command history
    rm -rf /tmp/elvish*
  '';
}
