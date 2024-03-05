{ config, lib, pkgs, ... }:

{	
		#services.greetd = {
		#	enable = true;
		#	settings = rec {
		#		initial_session = {
		#			command = ''
		#				${pkgs.river}/bin/river
		#				waitPID=$!
		#			'';
		#			user = "bear";
		#		};
		#		default_session = initial_session;
		#	};
		#};
		services.xserver = {
				enable = true;
				displayManager.gdm.enable = true;
				desktopManager.gnome.enable = true;

				displayManager.session = [{
					manage = "window";
					name = "river";
					start = ''
						${pkgs.river}/bin/river &
						waitPID=$!
					'';
				}];

				displayManager.sessionPackages = [
					(pkgs.river.overrideAttrs (prevAttrs: rec {
						postInstall =
							let
							riverSession = ''
								[Desktop Entry]
								Name=river
								Comment=Dynamic Wayland compositor
								Exec=river
								Type=Application
								'';
							in
							''
								mkdir -p $out/share/wayland-sessions
								echo "${riverSession}" > $out/share/wayland-sessions/river.desktop
							'';
						passthru.providedSessions = [ "river" ];
					}))
				];
		};
		
		environment.systemPackages = with pkgs; [
			river
			waybar
			wofi
			wbg
			mako
			kanshi
			wlr-randr

			(pkgs.river.overrideAttrs (prevAttrs: rec {
				postInstall =
					let
						riverSession = ''
							[Desktop Entry]
							Name=river
							Comment=Dynamic Wayland compositor
							Exec=river
							Type=Application
						'';
					in
					''
						mkdir -p $out/share/wayland-sessions
						echo "${riverSession}" > $out/share/wayland-sessions/river.desktop
					'';
					passthru.providedSessions = [ "river" ];
			}))
		];

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
