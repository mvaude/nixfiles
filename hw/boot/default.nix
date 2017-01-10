# Hardware boot settings
{ config, pkgs, ... }:

{

  initrd = import ./initrd;

  # Enable KVM kernel module
  kernelModules = [ "kvm-intel" ];

  # TODO: check extraModulePackages
  # extraModulePackages = [ ];

}
