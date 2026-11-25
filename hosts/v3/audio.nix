{ pkgs, ... }:

{
  # 内蔵ALC245のハードウェア音量が効かない場合も、音声データ側で減衰させる。
  services.pipewire.wireplumber.extraConfig."51-v3-software-volume" = {
    "monitor.alsa.rules" = [
      {
        matches = [{ "device.name" = "alsa_card.pci-0000_c4_00.6"; }];
        actions.update-props."api.alsa.soft-mixer" = true;
      }
    ];
  };

  # soft-mixerは既存のハードウェアミュートやゼロ音量を解除しない。
  # 起動時に再生・録音経路を0 dBへ戻し、通常の音量調整はPipeWireに任せる。
  systemd.services.v3-audio-mixer = {
    description = "Initialize V3 playback and capture hardware mixer";
    wantedBy = [ "multi-user.target" ];
    wants = [ "sound.target" ];
    after = [ "sound.target" "alsa-restore.service" ];
    serviceConfig.Type = "oneshot";
    path = [ pkgs.alsa-utils ];
    script = ''
      amixer -c Generic_1 sset Master 0dB unmute
      amixer -c Generic_1 sset Speaker 0dB unmute
      amixer -c Generic_1 sset Headphone 0dB unmute
      amixer -c Generic_1 sset PCM 0dB
      amixer -c Generic_1 sset 'Bass Speaker' unmute
      amixer -c Generic_1 sset Capture 0dB cap
      amixer -c Generic_1 sset 'Internal Mic Boost' 30dB
    '';
  };

  # Backport the pin correction from Linux commit
  # 72107104d4f522405c9dfdfbaeb230e371c295ee without replacing the
  # existing V3 speaker/headphone fixups or rebuilding the kernel.
  hardware.firmware = [
    (pkgs.writeTextDir "lib/firmware/v3-audio.fw" ''
      [codec]
      0x10ec0245 0x1f4ce001 0

      [pincfg]
      0x19 0x04a19150
    '')
  ];

  # Both HDA controllers load the file; the codec IDs restrict the fix
  # to the V3's Realtek codec, leaving HDMI audio untouched.
  boot.extraModprobeConfig = ''
    options snd-hda-intel patch=v3-audio.fw,v3-audio.fw
  '';
}
