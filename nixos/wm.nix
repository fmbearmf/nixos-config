{ config, lib, pkgs, ... }:

{	
		services.xserver = {
				enable = true;
				displayManager.gdm.enable = true;
				desktopManager.gnome.enable = true;
		};
		environment.gnome.excludePackages = (with pkgs; [
			gnome-photos
			gnome-tour
		]) ++ (with pkgs.gnome; [
			cheese
			gnome-music
			gnome-terminal
			epiphany
			geary
			evince
			gnome-characters
			totem
			tali
			iagno
			hitori
			atomix
		]);

		systemd.targets.sleep.enable = false;
		systemd.targets.suspend.enable = false;
		systemd.targets.hibernate.enable = false;
		systemd.targets.hybrid-sleep.enable = false;
}
