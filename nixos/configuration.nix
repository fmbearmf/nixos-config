{ config, lib, pkgs, ... }:

{
  imports = 
    [
      ./modules/quantum.nix
    ];
}