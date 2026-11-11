{ pkgs, ... }:

{
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
