{ neovim, writeText }:

let
  self = writeText "config-git" (builtins.readFile ./gitconfig);
in {
  environment_etc =
    [ { source = self;
        target = "gitconfig";
      }
    ];
  packages = {};
}
