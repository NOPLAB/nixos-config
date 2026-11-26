{ lib, ... }:

let
  # USB有線アダプタ（Realtek）。挿すポートで名前が変わるので、両方を許可する。
  interfaces = [ "enp198s0f4u1u3" "enp198s0f3u1u3" ];
  mac = "6C:1F:F7:D5:07:D0";
in
{
  networking.networkmanager.ensureProfiles.profiles = {
    v3-wired-dhcp = {
      connection = {
        id = "Wired DHCP";
        uuid = "ee108f1a-e115-4aa4-bbe1-22bd2433b07f";
        type = "ethernet";
        autoconnect = false;
      };
      ethernet.mac-address = mac;
      ipv4.method = "auto";
      ipv6.method = "auto";
    };

    v3-wired-nat = {
      connection = {
        id = "Wired NAT 192.168.1.1";
        uuid = "6835869e-6f1b-43ea-bc52-44a659a23b48";
        type = "ethernet";
        autoconnect = false;
      };
      ethernet.mac-address = mac;
      ipv4 = {
        method = "shared";
        address1 = "192.168.1.1/24";
        never-default = true;
      };
      ipv6.method = "disabled";
    };
  };

  # Allow clients to reach NetworkManager's shared DNS/DHCP service.
  networking.firewall.interfaces = lib.genAttrs interfaces (_: {
    allowedTCPPorts = [ 53 ];
    allowedUDPPorts = [ 53 67 ];
  });

  # DDSは動的なUDPポートを使うため、実機Piからの受信を送信元で限定する。
  networking.firewall.extraCommands = lib.concatMapStrings (i: ''
    iptables -I nixos-fw 1 -i ${i} -s 192.168.1.50/32 -p udp -j nixos-fw-accept
  '') interfaces;
  networking.firewall.extraStopCommands = lib.concatMapStrings (i: ''
    iptables -D nixos-fw -i ${i} -s 192.168.1.50/32 -p udp -j nixos-fw-accept 2>/dev/null || true
  '') interfaces;
}
