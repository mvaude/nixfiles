{ writeText, firefox }:


let
  self = brightness: writeText "config-termite" builtins.readFile ./config;
in {
  dark = self "dark";
  light = self "light";
  packages = {
    inherit firefox;
  };
}
