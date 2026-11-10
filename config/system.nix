{ pkgs, ... }:

{
  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 2;
    };
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  zramSwap.enable = true;

  services.fwupd.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
  ];
}
