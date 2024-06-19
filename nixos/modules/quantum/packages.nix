{ config, lib, pkgs, ... }:

{
	nixpkgs.config.allowUnfree = true;

	services.udev.packages = [ pkgs.via ];

	users.users.bear.packages = with pkgs; [
		vesktop # flatpak version isnt working for some reason
		nodejs
		(pkgs.pkgsi686Linux.gperftools)
		steamtinkerlaunch
		openvpn
		dotnetCorePackages.sdk_9_0	
		mprime
		insomnia
		libunwind
		cmake
		gnome.gnome-software
		via
		htop
		alacritty
		firefox-devedition-bin
		fira-mono
		fira
		yt-dlp
		gimp
		prismlauncher
		corepack
		vscode
		neofetch
		fastfetch
		screenfetch
		compsize
		obs-studio
		obs-studio-plugins.obs-vaapi
		youtube-dl
		kdenlive
		r2modman
		clang
		clang-tools
		any-nix-shell
		audacity
		fluent-reader
		qbittorrent
		gnumake
		pandoc
		sass
		socat
		mangohud
		mpv
		mc
		lazygit
		broot
		tetrio-desktop
		(blender-hip.withPackages( p: [ python311Packages.aiohttp ] ))
		ryujinx
		pcem
		geekbench
		imagemagick
		fbset
		freeglut
		protonup-qt
		nil
		nixpkgs-fmt
		protontricks
		xautoclick
	];

	environment.systemPackages = with pkgs; [
		pkg-config
		xdg-desktop-portal
		xdg-desktop-portal-gnome
		ffmpeg-full
		libstdcxx5
		gcc
		zig
		llvmPackages_17.clang
		openjdk21
		steam-run
		python311
		(python311.withPackages(ps: with ps; [ pandas requests aiohttp ]))
		go
		unzip
    		rust-analyzer-nightly
		php
		phpPackages.composer
		luarocks
		julia
		tree-sitter
		wl-clipboard
		dwarfs
		fuse-overlayfs
		fuse3
		wineWowPackages.stable
		winetricks
		bubblewrap
		gst_all_1.gst-libav
		gst_all_1.gst-plugins-bad
		gst_all_1.gst-plugins-base
		gst_all_1.gst-plugins-good
		gst_all_1.gst-plugins-ugly
		gst_all_1.gst-vaapi
		libvorbis
		mlocate
		openal
		glfw-wayland
		yad
		xorg.xwininfo
		unixtools.xxd
		xdotool
	];
	fonts.packages = with pkgs; [
		noto-fonts
		noto-fonts-cjk
		noto-fonts-emoji
		iosevka
		font-awesome
		material-icons
		nerdfonts
	];

	programs = {
		gamemode.enable = true;
		steam = {
			enable = true;
			remotePlay.openFirewall = true;
			dedicatedServer.openFirewall = true;
			gamescopeSession.enable = true;
		};
		nix-ld.enable = true;
	};
	nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
		"steam"
		"steam-original"
		"steam-run"
	];
}
