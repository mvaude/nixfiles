{ git, writeText }:

let
  self = writeText "git-config" (builtins.readFile ./gitconfig);
in {
  environment_etc =
    [ { source = self;
        target = "gitconfig";
      }
    ];
  packages = {
    inherit git;
  };
}
