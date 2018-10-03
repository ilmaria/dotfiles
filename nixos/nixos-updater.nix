{config, pkgs, lib, ...}:

{
   systemd.services.nixos-updater = {
     description = "Nixos updater";
     restartIfChanged = false;
     unitConfig.X-StopOnRemoval = false;

     serviceConfig.Type = "oneshot";

     environment = config.nix.envVars //
       { inherit (config.environment.sessionVariables) NIX_PATH;
         HOME = "/root";
       } // config.networking.proxy.envVars;

     path = [ pkgs.gnutar pkgs.xz.bin config.nix.package.out ];

     script = ''
       ${pkgs.nix}/bin/nix-channel --update nixos
       ${config.system.build.nixos-rebuild}/bin/nixos-rebuild boot
     '';
   };

   systemd.timers.nixos-updater = {
      wantedBy = [ "timers.target" ];
      description = "Delayed timer for Nixos updater";
      timerConfig.OnBootSec = "10min";
   };
}
