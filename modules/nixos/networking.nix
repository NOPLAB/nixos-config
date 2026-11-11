{ lib, pkgs, ... }:

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

  # Backport NixOS/nixpkgs#537675: SoftEther writes state beside argv[0].
  systemd.services.vpnclient.serviceConfig = {
    ExecStart = lib.mkForce "/var/lib/softether/vpnclient/vpnclient start";
    ExecStop = lib.mkForce "/var/lib/softether/vpnclient/vpnclient stop";
  };

  environment.systemPackages = with pkgs; [
    dhcpcd
    iproute2
  ];
}
