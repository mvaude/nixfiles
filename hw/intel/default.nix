{ config, lib, ... }:

{
  boot = {
    blacklistedKernelModules = [ "snd_pcsp" "pcspkr" ];
    kernelModules = [ "kvm-intel" ];

    initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ata_piix" "usbhid" "usb_storage" "sd_mod" ];
  };

  nix = {
    maxJobs = lib.mkDefault 12;
  };
}
