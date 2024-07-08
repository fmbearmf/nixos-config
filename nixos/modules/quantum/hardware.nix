{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.kernelPackages = pkgs.linuxPackages_cachyos-lto;

  boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "nvme" "usbhid" "sd_mod" "zstd" "btrfs"];
  boot.initrd.kernelModules = ["zstd" "btrfs"];
  boot.kernelModules = ["kvm-intel"];
  boot.extraModulePackages = [];
  boot.kernelParams = [
    "video=DP-1:2560x1440@165"
    "video=HDMI-A-1:1920x1200@60"
    "quiet"
    "splash"
  ];
  boot.kernel.sysctl = {"vm.swappiness" = 200;};

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/c50920a7-7aab-45f3-b124-49f6cbde2998";
    fsType = "btrfs";
    options = ["subvol=root" "compress=zstd:5"];
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/c50920a7-7aab-45f3-b124-49f6cbde2998";
    fsType = "btrfs";
    options = ["subvol=nix" "compress=zstd:5" "noatime"];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/CA09-84B2";
    fsType = "vfat";
  };

  fileSystems."/mnt" = {
    device = "/dev/disk/by-uuid/2105604F6B2AF39D";
    fsType = "ntfs-3g";
  };

  swapDevices = [];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
