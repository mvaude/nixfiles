{ termite, roboto, writeText }:


let
  self = writeText "termite-config" (builtins.readFile ./config);
in {
  environment_etc = [
    {
      source = self;
      target = "xdg/termite/config";
    }
  ];
  packages = { inherit roboto termite; };
}
