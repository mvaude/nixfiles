{ pkgs, ... }:

{
  imports =
    [ ./hw/rig.nix 
      (import ./bax.nix { i3_tray_output = "eDP1"; })
    ];

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;

  fileSystems."/" = {
      device = "/dev/disk/by-uuid/e784b28c-5a2d-4365-a232-8f2e1c66d36e";
      fsType = "ext4";
    };

  # hostId needed for zsh
  # cksum /etc/machine-id | while read c rest; do printf "%x" $c; done
  networking.hostId = "472528f0";

  nix.extraOptions = ''
    build-cores = 6
  '';
  nix.maxJobs = 12;

  networking.hostName = "thaddius";

  services.xserver.displayManager.slim.defaultUser = "bax";
  services.xserver.desktopManager.default = "none";

  services.xserver.videoDrivers = [ "nvidia" ];

  #systemd.user.services.dunst = {
  #  enable = true;
  #  description = "Lightweight and customizable notification daemon";
  #  wantedBy = [ "default.target" ];
  #  path = [ pkgs.dunst ];
  #  serviceConfig = {
  #    Restart = "always";
  #    ExecStart = "${pkgs.dunst}/bin/dunst";  # TODO configure theme
  #  };
  #};

  #systemd.user.services.i3lock-auto = {
  #  enable = true;
  #  description = "Automatically lock screen after 15 minutes";
  #  wantedBy = [ "default.target" ];
  #  path = with pkgs; [ xautolock i3lock-fancy ];
  #  serviceConfig = {
  #    Restart = "always";  # TODO: lockaftersleep does not work
  #    ExecStart = "${pkgs.xautolock}/bin/xautolock -lockaftersleep -detectsleep -time 15 -locker ${pkgs.i3lock-fancy}/bin/i3lock-fancy";
  #  };
  #};

  services.xserver.windowManager.default = "i3";
  services.xserver.windowManager.i3.enable = true;
  services.xserver.windowManager.i3.configFile = "/tmp/config/i3";

  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.package = pkgs.pulseaudioFull;
}
