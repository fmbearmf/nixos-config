{ config, lib, pkgs, ... }:

{
	nixpkgs.overlays = [
    		(import "${fetchTarball "https://github.com/nix-community/fenix/archive/main.tar.gz"}/overlay.nix") 
	];

	nixpkgs.config.allowUnfree = true;

	virtualisation.virtualbox.host.enable = true;

	users.users.bear.packages = with pkgs; [
		htop
		alacritty
		firefox-devedition-bin
		fira-mono
		fira
		vesktop
		yt-dlp
		gimp
		prismlauncher
		corepack
		nodejs_21
		nodePackages.webpack
		nodePackages.webpack-cli
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
		cider
		mangohud
		mpv
		mc
		lazygit
		broot
		tetrio-desktop
		blender-hip
		ryujinx
		pcem
		geekbench
		imagemagick
		fbset
	];

	environment.systemPackages = with pkgs; [
		xdg-desktop-portal
		xdg-desktop-portal-gnome
		ffmpeg
		libstdcxx5
		gcc
		zig
		llvmPackages_17.clang
		openjdk19
		steam-run
		python311
		python311Packages.pip
		(python311.withPackages (ps: with ps; [ pip ]))
		go
		unzip
		(fenix.complete.withComponents [
      			"cargo"
      			"clippy"
      			"rust-src"
      			"rustc"
      			"rustfmt"
    		])
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
	];
	fonts.packages = with pkgs; [
		noto-fonts
		noto-fonts-cjk
		noto-fonts-emoji
		iosevka
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
