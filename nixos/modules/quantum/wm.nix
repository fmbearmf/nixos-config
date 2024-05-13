{ config, lib, pkgs, ... }:

{	
	# GNOME
		services.xserver = {
				enable = true;
				displayManager.gdm.enable = true;
#				desktopManager.gnome.enable = true;
		};
#		
#		environment.gnome.excludePackages = (with pkgs; [
#			gnome-photos
#			gnome-tour
#		]) ++ (with pkgs.gnome; [
#			cheese
#			gnome-music
#			gnome-terminal
#			epiphany
#			geary
#			evince
#			gnome-characters
#			totem
#			tali
#			iagno
#			hitori
#			atomix
#		]);
#
		systemd.targets.sleep.enable = false;
		systemd.targets.suspend.enable = false;
		systemd.targets.hibernate.enable = false;
		systemd.targets.hybrid-sleep.enable = false;

	#Hyprland
		programs.hyprland = {
			xwayland.enable = true;
		};

		environment.sessionVariables = {
			NIXOS_OZONE_WL = "1";
		};

		environment.systemPackages = [
			(pkgs.waybar.overrideAttrs (oldAttrs: {
					mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
				})
			)
			pkgs.dunst
			pkgs.libnotify
			pkgs.swww	
			pkgs.tofi
		];	

		xdg.portal = {
			enable = true;
			extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
			config = {
				common = {
					default = [
						"gtk"
					];
				};
			};
		};
}
