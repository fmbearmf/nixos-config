{ config, lib, pkgs, ... }:

{
	networking = {
		nameservers = [ "127.0.0.1" "::1" ];
		dhcpcd.extraConfig = "nohook resolv.conf";
		networkmanager.dns = "none";
	};
	services.dnscrypt-proxy2 = {
		enable = true;
		settings = {
			ipv6_servers = false;
			require_dnssec = true;

			sources.public-resolvers = {
				urls = [
					"https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
					"https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
				];
				cache_file = "/var/lib/dnscrypt-proxy2/public-resolvers.md";
				minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
			};
		};
	};

	services.openvpn.servers = {
		us = {
			config = ''
				config /home/bear/.ovpn/us.ovpn
				push "resolv-retry infinite"
				route-nopull
			'';
			autoStart = false;
			authUserPass.password = builtins.readFile "/home/bear/.ovpn/pw";
			authUserPass.username = builtins.readFile "/home/bear/.ovpn/unm";
		};
	};

	systemd.services.dnscrypt-proxy2.serviceConfig = {
		StateDirectory = "dnscrypt-proxy";
	};
}
