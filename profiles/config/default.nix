{ pkgs, ... }:

let

  apps = {

    git = import ./git {
      inherit (pkgs) neovim writeText;
    };

    termite = import ./termite {
      inherit (pkgs) writeText firefox;
    };

    zsh = import ./zsh {
      inherit (pkgs) writeText fzf neovim less zsh-prezto;
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
      self.termite.packages //
      self.zsh.packages //
      {});  

  } // apps ;

in self
