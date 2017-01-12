{ writeText, firefox }:


let
  self = writeText "config-termite" (builtins.readFile ./config);
in {
  environment_etc = [
    {
      source = self;
      target = "xdg/termite.cfg";
    }
  ];
  packages = {
    inherit firefox;
  };
}
