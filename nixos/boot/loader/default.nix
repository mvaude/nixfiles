{ ... }:

{

  # Enable systemd to boot
  systemd-boot.enable = true;

  # Enable EFI variables
  efi.canTouchEfiVariables = true;

}
