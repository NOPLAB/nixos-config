{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./config
  ];

  # Compatibility baseline for this installation; keep across release upgrades.
  system.stateVersion = "26.05";
}
