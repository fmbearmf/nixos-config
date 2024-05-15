{ config, lib, pkgs, ... }:

{	
		services.xserver = {
				enable = true;
#				displayManager.gdm.enable = true;
#				desktopManager.gnome.enable = true;
#				displayManager.sddm = {
#					enable = true;
#					wayland.enable = true;
#				};
		};

		services.displayManager = {
			sddm.enable = true;
			sddm.wayland.enable = true;
		};

		services.desktopManager = {
			plasma6.enable = true;
		};

		environment.plasma6.excludePackages = with pkgs.kdePackages; [
			konsole
		];
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
#		programs.hyprland = {
#			enable = true;
#			xwayland.enable = true;
#		};

#		environment.sessionVariables = {
#			NIXOS_OZONE_WL = "1";
#		};

#		environment.systemPackages = [
#			(pkgs.waybar.overrideAttrs (oldAttrs: {
#					mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
#				})
#			)
#			pkgs.dunst
#			pkgs.libnotify
#			pkgs.swww	
#			pkgs.tofi
#			pkgs.networkmanagerapplet
#			pkgs.xfce.thunar
#			pkgs.grim
#			pkgs.slurp
#			pkgs.gnome.file-roller
#			pkgs.nwg-look
#			pkgs.libsForQt5.breeze-qt5
#			pkgs.libsForQt5.breeze-gtk
#		];	
#
#		xdg.portal = {
#			enable = true;
#			extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
#			config = {
#				common = {
#					default = [
#						"gtk"
#					];
#				};
#			};
#		};

		qt = {
			enable = true;
			platformTheme = "gnome";
			style = "adwaita-dark";
		};

		programs.dconf.enable = true;


}
