# Hardware boot initrd settings
{ config, pkgs, ... }:

{
  # Set hardware kernel modules
  availableKernelModules = [ "xhci_pci" "ehci_pci" "ata_piix" "usbhid" "sd_mod" ];

  # Set disk encryption
  luks = import ./luks;
}
