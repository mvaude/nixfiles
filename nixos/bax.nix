{ i3_tray_output }:

{ pkgs, config, ... }:

#xautolocakk
#  http://rabexc.org/posts/awesome-xautolock-battery
#  https://faq.i3wm.org/question/5102/i3lock-how-to-enable-auto-lock-after-wake-up-from-suspend-solved.1.html

# to package
#  https://pypi.python.org/pypi/weetwit
#  http://turses.readthedocs.io/en/latest/user/configuration.html#twitter
#  https://github.com/eliangcs/http-prompt

{

  imports =
    [ ( import ./common.nix { inherit i3_tray_output; }  )
    ];

  environment.etc = pkgs.mvaude_config.environment_etc;


  environment.systemPackages = with pkgs;
    mvaude_config.system_packages ++
    [

      mvaude_config.theme_switch

      termite.terminfo

      xsel # needed for neovim to support copy/paste

      # console applications
      # git flow CLI helper
      gitAndTools.gitflow
      gitAndTools.tig
      gitFull
      gnumake
      gnupg
      htop
      # gpg keys public CLI
      keybase
      # mobile shell
      mosh
      neovim
      # redirect  http through firewall
      ngrok
      # password manager
      pass
      # screenshot
      scrot
      st  # backup terminal
      # todo manager
      taskwarrior
      # uncompressers
      unrar
      unzip
      # vi bindings file manager
      vifm
      wget
      which
      # terminal recorder
      asciinema
      # pulse audio gui controller
      pavucontrol
      # media player
      mpv
      # internet video downloader
      youtube-dl
      tree
      # collaborative terminal
      pythonPackages.Flootty

      # gui applications
      pavucontrol
      zathura

    ];

  fonts.enableFontDir = true;
  fonts.enableGhostscriptFonts = true;
  fonts.fonts = with pkgs; [
    anonymousPro
    corefonts
    dejavu_fonts
    freefont_ttf
    liberation_ttf
    source-code-pro
    terminus_font
    ttf_bitstream_vera
    nerdfonts
  ];

  networking.extraHosts = ''
    127.0.0.1 ${config.networking.hostName}
    ::1 ${config.networking.hostName}
  '';

  # ipython shell
  programs.xonsh.enable = true;
  programs.zsh.enable = true;

  #security.polkit.extraConfig = ''
  #  polkit.addRule(function(action, subject) {
  #    var YES = polkit.Result.YES;
  #    // NOTE: there must be a comma at the end of each line except for the last:
  #    var permission = {
  #      // required for udisks1:
  #      "org.freedesktop.udisks.filesystem-mount": YES,
  #      "org.freedesktop.udisks.luks-unlock": YES,
  #      "org.freedesktop.udisks.drive-eject": YES,
  #      "org.freedesktop.udisks.drive-detach": YES,
  #      // required for udisks2:
  #      "org.freedesktop.udisks2.filesystem-mount": YES,
  #      "org.freedesktop.udisks2.encrypted-unlock": YES,
  #      "org.freedesktop.udisks2.eject-media": YES,
  #      "org.freedesktop.udisks2.power-off-drive": YES,
  #      // required for udisks2 if using udiskie from another seat (e.g. systemd):
  #      "org.freedesktop.udisks2.filesystem-mount-other-seat": YES,
  #      "org.freedesktop.udisks2.filesystem-unmount-others": YES,
  #      "org.freedesktop.udisks2.encrypted-unlock-other-seat": YES,
  #      "org.freedesktop.udisks2.eject-media-other-seat": YES,
  #      "org.freedesktop.udisks2.power-off-drive-other-seat": YES
  #    };
  #    if (subject.isInGroup("wheel")) {
  #      return permission[action.id];
  #    }
  #  });
  #'';

  #services.xserver.displayManager.sessionCommands = ''
  #  ${pkgs.mvaude_config.theme_switch}/bin/switch-theme
  #'';

  users.users."bax" = {
    isNormalUser = true;
    uid = 1000;
    description = "Maxime Vaude";
    extraGroups = [ "wheel" "vboxusers" "networkmanager" "docker" ] ;
    group = "users";
    home = "/home/bax";
    shell = "/run/current-system/sw/bin/zsh";
  };

  virtualisation.docker.enable = true;
  virtualisation.docker.socketActivation = true;

}
