{ pkgs, ... }:

{
  imports =
    [ ./hw/rig.nix 
      (import ./bax.nix { i3_tray_output = "eDP1"; })
    ];

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.gummyboot.enable = true;

  fileSystems."/" = {
      device = "/dev/disk/by-uuid/8091fc09-6260-4259-ac77-69fb9f9be067";
      fsType = "ext4";
    };

  # hostId needed for zsh
  # cksum /etc/machine-id | while read c rest; do printf "%x" $c; done
  networking.hostId = "7eb16a6c";

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
}
