{ config, lib, pkgs, ... }:

{
  imports = 
    [
      ./packages.nix # Change contents
      ./quantum/quantum-configuration.nix # Change this
    ];
}