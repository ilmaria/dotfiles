{config, pkgs, lib, ...}:

{
   systemd.services.nixosUpdater = {
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
       ${config.system.build.nixos-rebuild}/bin/nixos-rebuild switch --upgrade
     '';
   };

   systemd.timers.nixosUpdater = {
      wantedBy = [ "timers.target" ];
      description = "Delayed timer for Nixos updater";
      timerConfig.OnBootSec = "10min";
   };
}
