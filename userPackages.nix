self: super:
{
  allowUnfree = true;

  userPackages = with builtins; super.userPackages or {} //
    (let
      rawPackageNames = super.lib.splitString "\n" (readFile ../packages);
      packageNames = filter (x: x != "") rawPackageNames;
      nameToAttr = (packageName:
        { name = packageName; value = getAttr packageName super; }
      );
    in
      listToAttrs (map nameToAttr packageNames))

    //

    {

      haskellEnv = super.haskellPackages.ghcWithPackages (pkgs:
        with pkgs; [
          ghc-mod
          xmobar
        ]
      );

#      haskellPackages = super.haskellPackages.override {
#        haskellPackages.ghc-mod = super.haskellPackages.ghc-mod;
#        haskellPackages.xmobar = super.haskellPackages.xmobar;
#      };

      nix-rebuild = super.writeScriptBin "nix-rebuild"
        '' #! ${super.stdenv.shell}
          #export NIXPKGS_ALLOW_UNFREE=1
          exec nix-env -f '<nixpkgs>' -iA userPackages
        '';

      nix-query = super.writeScriptBin "nix-query"
        ''
          #! ${super.stdenv.shell}
          #export NIXPKGS_ALLOW_UNFREE=1
          exec nix-env -f '<nixpkgs>' -qaP --description "$@"
        '';
    };
}
