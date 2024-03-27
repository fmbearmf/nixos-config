{ config, lib, pkgs, ... }:

let
  module = "quantum"; # Change to configuration module name
in
{
  imports = 
    [
      ./modules/${module}/module.nix
    ];
}