{ config, ... }:

{
  # Select internationalisation properties.
  i18n = {
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };
  
  networking.hostName = "thaddius"; # Define your hostname.
  # hostId needed for zsh
  # cksum /etc/machine-id | while read c rest; do printf "%x" $c; done
  # networking.hostId = "47258f0";
}
