{ config, lib, pkgs, ... }:

{
	virtualisation.libvirtd = {
		enable = true;

		qemu = {
			package = pkgs.qemu_kvm;
			ovmf.enable = true;
			ovmf.packages = [ pkgs.OVMFFull.fd ];
			swtpm.enable = true;
			runAsRoot = false;
		};
	};

	programs.virt-manager.enable = true;
	users.users.bear.extraGroups = [ "libvirtd" "qemu-libvirtd" ];

	environment.etc = {
		"ovmf/edk2-x86_64-secure-code.fd" = {
			source = config.virtualisation.libvirtd.qemu.package + "/share/qemu/edk2-x86_64-secure-code.fd";
		};
		"ovmf/edk2-i386-vars.fd" = {
    			source = config.virtualisation.libvirtd.qemu.package + "/share/qemu/edk2-i386-vars.fd";
  		};
	};
}
