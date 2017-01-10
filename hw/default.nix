{ config, pkgs, ... }:

{

  boot = import ./boot;
  fileSystems = import ./fileSystems;
  nix = import ./nix ;

}
