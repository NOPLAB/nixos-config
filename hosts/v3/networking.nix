{ ... }:

let
  interface = "enp198s0f4u1u3";
in
{
  networking.networkmanager.ensureProfiles.profiles = {
    v3-wired-dhcp = {
      connection = {
        id = "Wired DHCP";
        uuid = "ee108f1a-e115-4aa4-bbe1-22bd2433b07f";
        type = "ethernet";
        interface-name = interface;
        autoconnect = false;
      };
      ipv4.method = "auto";
      ipv6.method = "auto";
    };

    v3-wired-nat = {
      connection = {
        id = "Wired NAT 192.168.1.1";
        uuid = "6835869e-6f1b-43ea-bc52-44a659a23b48";
        type = "ethernet";
        interface-name = interface;
        autoconnect = false;
      };
      ipv4 = {
        method = "shared";
        address1 = "192.168.1.1/24";
        never-default = true;
      };
      ipv6.method = "disabled";
    };
  };

  # Allow clients to reach NetworkManager's shared DNS/DHCP service.
  networking.firewall.interfaces.${interface} = {
    allowedTCPPorts = [ 53 ];
    allowedUDPPorts = [ 53 67 ];
  };

  # DDSは動的なUDPポートを使うため、実機Piからの受信を送信元で限定する。
  networking.firewall.extraCommands = ''
    iptables -I nixos-fw 1 -i ${interface} -s 192.168.1.50/32 -p udp -j nixos-fw-accept
  '';
  networking.firewall.extraStopCommands = ''
    iptables -D nixos-fw -i ${interface} -s 192.168.1.50/32 -p udp -j nixos-fw-accept 2>/dev/null || true
  '';
}
