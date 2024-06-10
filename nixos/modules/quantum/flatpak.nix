{ config, lib, pkgs, ... }:

{
	services.flatpak.enable = true;
	xdg.portal = {
		enable = true;
		wlr.enable = true;
		extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-wlr ];
		config = {
			common = {
				default = [
					"wlr"
				];
			};
		};
	};
}
