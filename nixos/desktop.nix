{ config, lib, pkgs, ... }:

{
	environment.systemPackages = [
		(pkgs.makeDesktopItem {
			name = "ryujinx";
			desktopName = "Ryujinx";
			exec = "ryujinx";
			terminal = false;
		})
	];

}
