{ writeText, fzf, neovim, less, zsh, zsh-prezto }:

let
  self = writeText "zsh-config" (builtins.readFile ./zshrc);
in {
  light = self;
  dark = self;
  environment_etc = [
    {
      source = "${zsh-prezto}/runcoms/zlogin";
      target = "zlogin";
    }
    {
      source = "${zsh-prezto}/runcoms/zlogout";
      target = "zlogout";
    }
    {
      source = self;
      target = "zpreztorc";
    }
    {
      source = "${zsh-prezto}/runcoms/zprofile";
      target = "zprofile.local";
    }
    {
      source = "${zsh-prezto}/runcoms/zshenv";
      target = "zshenv.local";
    }
    {
      source = "${zsh-prezto}/runcoms/zshrc";
      target = "zshrc.local";
    }
  ];
  packages = {
      inherit fzf neovim less zsh zsh-prezto;
  };
}
