{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./audio.nix
    ../../modules/nixos
  ];

  fileSystems."/mnt/windows" = {
    device = "/dev/disk/by-uuid/B8525008524FCA38";
    fsType = "ntfs3";
    options = [ "ro" "nofail" ];
  };

  # Compatibility baseline for this installation; keep across release upgrades.
  system.stateVersion = "26.05";
}
