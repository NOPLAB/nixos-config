{ pkgs, ... }:

{
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    networkmanager.unmanaged = [ "interface-name:vpn_uedac" ];
    dhcpcd.denyInterfaces = [ "vpn_uedac" ];
  };

  services.tailscale.enable = true;
  services.softether = {
    enable = true;
    vpnclient.enable = true;
  };

  environment.systemPackages = with pkgs; [
    dhcpcd
    iproute2
  ];
}
