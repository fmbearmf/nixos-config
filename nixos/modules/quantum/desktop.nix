{
  config,
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = [
    (pkgs.makeDesktopItem {
      name = "ryujinx";
      desktopName = "Ryujinx";
      exec = "ryujinx";
      terminal = false;
    })
    (pkgs.makeDesktopItem {
      name = "pcem";
      desktopName = "PCem";
      exec = "pcem";
      terminal = false;
    })
  ];
}
