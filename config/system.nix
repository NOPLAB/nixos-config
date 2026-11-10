{ pkgs, ... }:

{
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  zramSwap.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
  ];
}
