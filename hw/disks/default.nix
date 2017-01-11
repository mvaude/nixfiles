{ config, ... }:

{
  boot = {

    initrd = {

      luks = {

        cryptoModules = [ "aes" "sha256" "sha1" "cbc" ];

	devices = [{

	  name = "root";
	  device = "/dev/disk/by-path/pci-0000:00:1f.5-ata-1-part4";
	  # for ssd
	  allowDiscards = true;
	  preLVM = true;

	}];

      };

    };

  };

  fileSystems = {

    "/" = {

      mountPoint = "/";
      device = "/dev/mapper/thaddius-root";
      fsType = "ext4";
      options = [ "noatime,nodiratime,discard" ];

    };

    "/boot" = {

      mountPoint = "/boot";
      device = "/dev/disk/by-path/pci-0000:00:1f.5-ata-1-part2";
      fsType = "vfat";

    };

    "/home" = {

      mountPoint = "/home";
      device = "/dev/mapper/thaddius-home";
      fsType = "ext4";

    };

  };
}
