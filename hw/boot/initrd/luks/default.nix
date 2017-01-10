# Hardware boot settings
{ config, pkgs, ... }:

{
  # Enable crypto modules
  cryptoModules = [ "aes" "sha256" "sha1" "cbc" ];

  # Set Disks
  devices = [
    {
      name = "root";
      device = "/dev/disk/by-path/pci-0000:00:1f.5-ata-1-part4";
      # For ssd
      allowDiscards = true;
      preLVM = true;
    }
  ];
}
