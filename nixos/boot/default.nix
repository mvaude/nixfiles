{ lib, ... }:

{

  # Import bootloader settings 
  loader = import ./loader;

  # Keep up to date with latest kernel released
  kernelPackages = lib.linuxPackages_latest;

}
