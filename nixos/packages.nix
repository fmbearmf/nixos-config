{ config, lib, pkgs, ... }:

{
	nixpkgs.config.allowUnfree = true;
	users.users.bear.packages = with pkgs; [
		kitty
		firefox-devedition-bin
		fira-mono
		fira
		vesktop
		yt-dlp
		gimp
		cider
		prismlauncher
		corepack
		nodejs_21
		vscode

	];
	environment.systemPackages = with pkgs; [
		xdg-desktop-portal
		xdg-desktop-portal-gnome
		ffmpeg
		libstdcxx5
		gcc
		zig
		llvmPackages_17.clang
	];
}
