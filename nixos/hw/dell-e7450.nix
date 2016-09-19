{ pkgs, ... }:

{
  boot = {
    blacklistedKernelModules = [ "snd_pcsp" "pcspkr" ];
    extraModprobeConfig = ''
      options snd_hda_instal mode=auto power_save=1 index=1
    '';

    initrd = {
      availableKernelModules = [ "snd_pcsp" "pcspkr" ];
      kernelModules = [ "xhci_hcd" "ehci_pci" "ahci" "usb_storage" "aesni-intel" "fbcon" "i915" ];

      luks = {
        cryptoModules = [ "aes" "xts" "sha512" "sha256" ];

        devices = [
	  {
	    allowDiscards = true;
	    name = "root";
	    device = "/dev/sda2";
	    preLVM = true;
	  }
	];
      };
    };

    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [ "i915.enable_ips=0" "intel_pstate=no_hwp" ];
    kernelModules = [ "kvm-intel" "msr" "bbswitch" "ecryptfs" ];

    loader = {
      efi.canTouchEfiVariables = true;

      grub = {
	configurationLimit = 50;
	device = "nodev";
	efiSupport = true;
        enable = true;
	gfxmodeEfi = "1024*768";
	memtest86.enable = false;
	version = 2;
      };
    };

    vesa = false;
  };

  fileSystems = {
    "/" = {
      device = "dev/vg/root";
      label = "root";
      fsType = "ext4";
      options = [ "noatime" "nodiratime" "discard" ];
    };

    "/boot" = {
      device = "/dev/disk/by-label/BOOT";
      mountPoint = "/boot";
    };
  };

  hardware = {
    bluetooth.enable = false;

    cpu.intel.updateMicrocode = true;

    opengl = {
      driSupport32Bit = true;
      extraPackages = [ pkgs.vaapiIntel ];
    };

    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
      support32Bit = true;
    };

    trackpoint = {
      enable = true;
      sensitivity = 200;
      emulateWheel = true;
    };
  };

  networking = {
    firewall = {
      enable = true;
      allowPing = false;
    };

    hostName = "maxime-scality";
    #networkmanager.enable = true;
    wireless.enable = true;
  };

  powerManagement = {
    cpuFreqGovernor = "ondemand";
    enable = true;
    scsiLinkPolicy = "max_performance";
  };

  swapDevices = [
    {
      device = "/dev/vg/swap";
    }
  ];
}
