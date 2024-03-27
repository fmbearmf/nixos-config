{ config, lib, pkgs, ... }:

let
  module = "quantum"; # Config module name
in
{
  imports = 
    [
      ./modules/${module}/module.nix
    ];
}
