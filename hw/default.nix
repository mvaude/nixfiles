{ config, pkgs, ... }:

{
  # Select internationalisation properties.
  i18n = {
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };
  
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.package = pkgs.pulseaudioFull;
  hardware.opengl.driSupport32Bit = true;

  networking.hostName = "thaddius"; # Define your hostname.
  # hostId needed for zsh
  # cksum /etc/machine-id | while read c rest; do printf "%x" $c; done
  networking.hostId = "1321e85a";
  # networking.extraHosts = ''
  #   127.0.0.1 ${config.networking.hostName}
  #   ::1 ${config.networking.hostName}
  # '';
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 80 8080 8000 ];

  # By default, containers cannot talk to the outside network. If you want that, you should set up Network Address
  # Translation (NAT) rules on the host to rewrite container traffic to use your external IP address. This can be
  # accomplished using the following configuration on the host:
  networking.nat.enable = true;
  networking.nat.internalInterfaces = ["ve-+"];
  networking.nat.externalInterface = "eth0";
}
