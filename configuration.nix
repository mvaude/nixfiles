# Global config
{ config, lib, pkgs, ... }:

{

  # Import main settings
  imports = [
    ./profiles
    ./hw
    ./hw/intel
    ./hw/disks
  ];

}
