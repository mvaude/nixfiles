# Hardware boot settings
{ config, pkgs, ... }:

{

  # Set root device
  "/" = {
    mountPoint = "/";
    device = "/dev/mapper/thaddius-root";
    fsType = "ext4";
    options = [ "noatime,nodiratime,discard" ];
  };

  # TODO: needed?
  "/boot" = {
    mountPoint = "/boot";
    device = "/dev/disk/by-path/pci-0000:00:1f.5-ata-1-part2";
    fsType = "vfat";
  };

  # Set home device
  "/home" = {
    mountPoint = "/home";
    device = "/dev/mapper/thaddius-home";
    fsType = "ext4";
  };

}
