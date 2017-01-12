# Global config
{ config, lib, pkgs, ... }:

{

  # Import main settings
  imports = [
    ./profiles
    ./hw/intel
    ./hw/disks
  ];

}
