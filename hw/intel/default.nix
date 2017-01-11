{ config, lib, ... }:

{
  boot = {
    kernelModules = [ "kvm-intel" ];
  };

  nix = {
    maxJobs = lib.mkDefault 12;
  };
}
