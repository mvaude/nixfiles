{ awesome, writeText }:

let
  self = writeText "awesome-config" (builtins.readFile ./rc.lua);
in {
  environment_etc = [
    {
      source = self;
      target = "xdg/awesome/rc.lua";
    }
  ];
  packages = {
    inherit awesome;
  };
}
