{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./quantum/packages.nix
    ];
}