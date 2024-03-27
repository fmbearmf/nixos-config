{ config, pkgs, ... }:

{
	virtualisation.docker = {
		enable = true;
		storageDriver = "btrfs";
	};

	users.users.bear.extraGroups = [ "docker" ];
}
