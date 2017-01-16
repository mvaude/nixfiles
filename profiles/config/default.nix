{ pkgs, ... }:

let

  apps = {

    # TODO: configure awesome
    awesome = import ./awesome {
      inherit (pkgs) awesome writeText;
    };

    git = import ./git {
      inherit (pkgs) git writeText;
    };

    zsh = import ./zsh {
      inherit (pkgs) writeText fzf neovim less zsh zsh-prezto;
    };

    termite = import ./termite {
      inherit (pkgs) termite roboto writeText;
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
# 	    if builtins.getAttr "environment_etc" app
	    app.environment_etc
#             else [
# 	      {
# 	        source = app.config;
# 	        target = "xdg/${appName}/${app.filename}";
#               }
# 	    ]
        ) (builtins.attrNames apps)));

      # TODO: loop over apps
      system_packages = builtins.attrValues (
        self.awesome.packages //
        self.git.packages //
        self.termite.packages //
        self.zsh.packages //
        {});

  } // apps ;

in self
