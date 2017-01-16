{ config, pkgs, ... }:

{
  # Select internationalisation properties.
  i18n = {
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };
  
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.enable = pkgs.pulseaudioFull;

  networking.hostName = "thaddius"; # Define your hostname.
  # hostId needed for zsh
  # cksum /etc/machine-id | while read c rest; do printf "%x" $c; done
  # networking.hostId = "16554942";
}
