{ i3_tray_output }:

{ pkgs, config, ... }:
{

  boot.blacklistedKernelModules = [ "snd_pcsp" "pcspkr" ];
  boot.kernelModules = [ "intel_agp" "i915" ];
  boot.kernelPackages = pkgs.linuxPackages_4_6;

  environment.systemPackages = with pkgs; [

     # gui apps
    firefox
    chromium
    vlc
    tdesktop

    # nix tools
    nix-prefetch-scripts
    nix-repl
    nixops
    nodePackages.npm2nix
    nox

  ];

  i18n.consoleFont = "Lat2-Terminus16";
  i18n.consoleKeyMap = "us";
  i18n.defaultLocale = "en_US.UTF-8";

  networking.networkmanager.enable = true;

  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 80 8080 8000 ];

  // By default, containers cannot talk to the outside network. If you want that, you should set up Network Address
  // Translation (NAT) rules on the host to rewrite container traffic to use your external IP address. This can be
  // accomplished using the following configuration on the host:
  networking.nat.enable = true;
  networking.nat.internalInterfaces = ["ve-+"];
  networking.nat.externalInterface = "eth0";

  nix.package = pkgs.nixUnstable;
  nix.binaryCachePublicKeys = [
    "hydra.nixos.org-1:CNHJZBh9K4tP3EKF6FkkgeVYsS3ohTl+oS0Qa8bezVs="
  ];
  nix.useSandbox = true;
  nix.trustedBinaryCaches = [ "https://hydra.nixos.org" ];
  nix.extraOptions = ''
    gc-keep-outputs = true
    gc-keep-derivations = true
    auto-optimise-store = true
  '';

  nixpkgs.config.allowBroken = false;
  // Allow Propriety packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreeRedistributable = true;
  nixpkgs.config.packageOverrides = pkgs: (import ./../pkgs { inherit pkgs i3_tray_output; });
  nixpkgs.config.firefox.enableAdobeFlash = true;
  nixpkgs.config.firefox.enableGoogleTalkPlugin = true;
  nixpkgs.config.zathura.useMupdf = true;


  programs.ssh.forwardX11 = false;
  programs.ssh.startAgent = true;

  security.sudo.enable = true;

  services.dbus.enable = true;
  services.locate.enable = true;
  services.nixosManual.showManual = true;
  services.openssh.enable = true;

  // printer settings
  services.printing.enable = false;
  // services.printing.drivers = [ pkgs.brother-hl2030 ];

  services.xserver.autorun = true;
  services.xserver.enable = true;
  services.xserver.exportConfiguration = true;
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "eurosign:e";

  services.xserver.desktopManager.xterm.enable = false;

  systemd.extraConfig = ''
    DefaultCPUAccounting=true
    DefaultBlockIOAccounting=true
    DefaultMemoryAccounting=true
    DefaultTasksAccounting=true
  '';

  users.mutableUsers = false;
  users.users."root".shell = "/run/current-system/sw/bin/zsh";

  time.timeZone = "Europe/Paris";

  virtualisation.virtualbox.host.enable = true;
}
