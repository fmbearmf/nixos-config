{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware.nix
      ./sudo.nix
      ./zram.nix
      ./wm.nix
      ./dns.nix
      ./lutris.nix
      ./virt.nix
      ./desktop.nix
      ./packages.nix
	  ./docker.nix
	  ./flatpak.nix
    ];

    nix = {
    	binaryCachePublicKeys = [
      		"nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      		"nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
    	];
    	binaryCaches = [
      		"https://cache.nixos.org/" 
     		"https://nix-community.cachix.org"
      		"https://nixpkgs-wayland.cachix.org"
    	];
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.memtest86.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "quantum";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Los_Angeles";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
  	packages = [ pkgs.terminus_font ];
    font = "ter-v32n";
    useXkbConfig = true;
   };

  hardware.opengl.enable = true;
  hardware.opengl.driSupport= true;
  hardware.opengl.driSupport32Bit = true;

  hardware.opengl = {
	extraPackages = with pkgs; [
		vaapiVdpau
		libvdpau-va-gl
		rocm-opencl-icd 
		rocm-opencl-runtime
	];
  };

  environment.sessionVariables = { LIBVA_DRIVER_NAME = "radeonsi"; };

  systemd.tmpfiles.rules = [
		"L+		/opt/rocm/hip	-	-	-	-	${pkgs.rocmPackages.clr}"
  ];

  services.xserver.videoDrivers = [ "amdgpu" ];

  services.printing.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = false;

  services = {
	pipewire = {
		enable = true;
		audio.enable = true;
		pulse.enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		jack.enable = true;
		wireplumber.enable = true;
	};
  };

  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

  programs.fish.promptInit = ''
  	${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source
  '';

  users.users.bear = {
    isNormalUser = true;
    extraGroups = [ "wheel" "render" ];
    packages = with pkgs; [
      tree
    ];
    shell = pkgs.fish;
  };
  users.extraGroups.vboxusers.members = [ "bear" ];

  environment.systemPackages = with pkgs; [
    wget
	btrfs-progs		
	moreutils
	binutils
	file
	psmisc
	netcat
	curl
	wget
	pciutils
	iputils
	powertop
	patchutils
	nix-index
	direnv
	git
	jq
	ripgrep
	fd
	mesa
  ];

  programs.neovim = {
	enable = true;
	defaultEditor = true;
	viAlias = true;
	vimAlias = true;
  };

  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.openssh.enable = false;

  system.copySystemConfiguration = true;

  # Don't touch this. It won't switch NixOS versions.
  system.stateVersion = "23.11"; # Did you read the comment?
}
