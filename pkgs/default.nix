{ pkgs
, i3_tray_output
}:

rec { 

  mvaude_config = import ../config { inherit pkgs base16-builder i3_tray_output; };

  # TODO:
  #  - py3status configured
  #  - replace offlineimap with isync and add to systemd
  #  - add afew to systemd
  #  - create alot theme

  nixos_slim_theme = pkgs.fetchurl {
    url = "https://github.com/jagajaga/nixos-slim-theme/archive/master.tar.gz";
    rev = "ba8761c473f6a8da350208f464701344ccb05383";
  };

  firefox = pkgs.firefox-beta-bin;

  ttf_bitstream_vera = pkgs.callPackage ./ttf_bitstream_vera {
    inherit (pkgs) stdenv fetchgit;
  };

  base16-builder = (import ./base16-builder {
    inherit pkgs;
    src = pkgs.fetchFromGitHub {
      owner = "base16-builder";
      repo = "base16-builder";
      rev = "fa72b56be3a44e79467303a19adbe0ca62ba198a";
      sha256 = "1c5d1a9k0j0qw41bf6xckki3z5g14k7zwwwbp9g2p2yzccxzjy1s";
    };
  }).package;

  rofi = pkgs.rofi.override { i3Support = true; };

  # should be part of config really

  termite = pkgs.termite.override { configFile = "/tmp/config/termite"; };

  neovim = pkgs.neovim.override {
    vimAlias = true;
    configure = import ./nvim_config.nix { inherit pkgs; inherit (mvaude_config) theme; };
  };

}

