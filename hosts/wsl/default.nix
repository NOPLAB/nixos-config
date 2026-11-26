{ lib, ... }:

{
  imports = [
    ../../modules/nixos
  ];

  wsl.enable = true;
  wsl.defaultUser = "nop";

  profiles.desktop.enable = false;

  # WSL manages the network and resolv.conf itself.
  networking.hostName = lib.mkForce "wsl";
  networking.networkmanager.enable = lib.mkForce false;

  # Compatibility baseline for this installation; keep across release upgrades.
  system.stateVersion = "26.05";
}
