{ config, lib, pkgs, ... }:

{
	desktopItems = [
		(makeDesktopItem {
			name = "ryujinx";
			exec = "ryujinx";
			desktopName = "Ryujinx";
			categories = [ "Emulators" ];
			comment = "Switch emulator.";
			icon = "ryujinx";
		})
	];
}
