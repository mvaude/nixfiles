# Global config
{ config, lib, pkgs, ... }:
# TODO: config default
# let
#   mvaude_config = import ../config { inherit pkgs; };
# in {
#
{

  # Import main settings
  imports = [
    ./profiles
    ./profiles/desktop
    ./hw/intel
    ./hw/disks
  ];

}
