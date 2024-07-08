{
  config,
  lib,
  pkgs,
  pkgs-stable,
  ...
}: let
  tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
in {
  services.xserver = {
    enable = true;
  };

  #services.greetd = {
  #	enable = true;
  #	settings = {
  #		default_session = {
  #			command = "${tuigreet} --time --remember --remember-session --cmd wayfire";
  #			user = "bear";
  #		};
  #	};
  #};

  #services.seatd = {
  #	enable = true;
  #	group = "users";
  #	user = "bear";
  #};

  nixpkgs.overlays = [
    (self: super: {
      gamescope = super.gamescope.overrideAttrs (_: rec {
        postInstall = let
          gamescopeSession = ''
            [Desktop Entry]
            Name=steam-gamescope
            Comment=yeah
            Exec=STEAM_MULTIPLE_XWAYLANDS=1 ${pkgs-stable.gamescope} -W 2560 -H 1440 -r 165 -e --xwayland-count 2 --adaptive-sync --display-index DP-2 -- steam -gamepadui -steamdeck -steamos3
            Type=Application
          '';
        in ''
          mkdir -p $out/share/wayland-sessions
          echo "${gamescopeSession}" > $out/share/wayland-sessions/gamescope.desktop
        '';
        passthru.providedSessions = ["gamescope"];
      });
    })
  ];

  services.displayManager = {
    sessionPackages = [
      pkgs.gamescope
    ];
    sddm = {
      enable = true;
      wayland.enable = true;
    };
  };

  services.desktopManager = {
    plasma6.enable = true;
  };

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    konsole
  ];

  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;

  programs.dconf.enable = true;
  security.polkit.enable = true;
}
