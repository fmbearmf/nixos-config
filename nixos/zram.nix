{ config, pkgs, ... }:

{
	zramSwap = {
		enable = true;
		memoryPercent = 100;
		priority = 100;
	};
}
