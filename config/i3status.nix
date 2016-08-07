{ writeText, theme }:

let
  self = brightness: writeText "i3status-config-${brightness}"
    ''
      ${builtins.replaceStrings
        [ "general {" "color_bad = \""]
        [ "general {\n    interval = 5" "color_bad = \"#" ]
        (builtins.readFile "${theme}/i3status.${brightness}")
        }

      order += "disk /"

      disk "/" {
        format = "%free"
      }

      order += "ethernet enp0s25"

      ethernet enp0s25{
        # if you use %speed, i3status requires root privileges
        format_up = "E: %ip (%speed)"
        format_down = "E: down"
      }

      order += "cpu_temperature 0"

      cpu_temperature 0 {
        format = "T: %degrees °C"
      }

      order += "sysdata"

      order += "time"

      time {
        format = "%Y-%m-%d %H:%M:%S"
      }

    '';

in {
  light = self "light";
  dark = self "dark";
  packages = {};
}
