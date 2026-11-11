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
    networkmanager.unmanaged = [ "interface-name:vpn_uedac" ];
    dhcpcd.denyInterfaces = [ "vpn_uedac" ];
  };

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
  };

  services.fwupd.enable = true;
  services.tailscale.enable = true;
  services.softether = {
    enable = true;
    vpnclient.enable = true;
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    dhcpcd
    iproute2
  ];
}
