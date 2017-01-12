{ pkgs, ... }:

let

  apps = {
    git = import ./git {
      inherit (pkgs) neovim writeText;
    };
  };

  # -- NIXOS --

  self = {
    environment_etc =
      (pkgs.lib.flatten (map
        (appName:
          let
            app = builtins.getAttr appName apps;
          in
            app.environment_etc
        ) (builtins.attrNames apps)));

    # TODO: loop over apps
    system_packages = builtins.attrValues (
      self.git.packages //
      {});  
  } // apps ;

in self
