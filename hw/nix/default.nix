# Hardware boot settings
{ lib, ... }:

{

  # Set max virtual threads
  maxJobs = lib.mkDefault 12;

}
