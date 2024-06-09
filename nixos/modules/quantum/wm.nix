{ config, lib, pkgs, ... }:

{	
		services.xserver = {
				enable = true;
		};

		environment.systemPackages = with pkgs; [
			wayfire-with-plugins
		];

		services.greetd = {
			enable = true;
			settings = {
				default_session = {
					command = "${pkgs.greetd.greetd}/bin/agreety --cmd wayfire";
					user = "bear";
				};
			};
		};

		#services.displayManager.sddm = {
		#	enable = true;
		#	wayland = {
		#		enable = true;
		#	};
		#};

		#services.desktopManager = {
		#	plasma6.enable = true;
		#};
#
#		environment.plasma6.excludePackages = with pkgs.kdePackages; [
#			konsole
#		];
#		
		systemd.targets.sleep.enable = false;
		systemd.targets.suspend.enable = false;
		systemd.targets.hibernate.enable = false;
		systemd.targets.hybrid-sleep.enable = false;

		programs.dconf.enable = true;
}
