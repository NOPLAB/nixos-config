{ lib
, stdenv
, fetchurl
, autoPatchelfHook
, makeWrapper
, makeDesktopItem
, copyDesktopItems
, wayland
, libxkbcommon
, libGL
, vulkan-loader
, libxcb
, pipewire
, libpulseaudio
, pam
, webkitgtk_4_1
}:

stdenv.mkDerivation rec {
  pname = "tern";
  version = "0.9.14";

  src = fetchurl {
    url = "https://build.stencil.so/d/tern/20261110-001919-6071256/Tern-${version}-linux-x86_64.tar.gz";
    hash = "sha256-BCiqLpp82q3qxoYW0GYEXutcNI1ebYD2bHFfGziJNZw=";
  };

  nativeBuildInputs = [ autoPatchelfHook makeWrapper copyDesktopItems ];
  buildInputs = [ stdenv.cc.cc.lib ];
  dontConfigure = true;
  dontBuild = true;
  # Keep the upstream binary intact apart from ELF loader/library paths.
  dontStrip = true;

  desktopItems = [ (makeDesktopItem {
    name = "tern";
    desktopName = "Tern";
    comment = "Stencil terminal";
    exec = "tern";
    icon = "utilities-terminal";
    terminal = false;
    categories = [ "System" "TerminalEmulator" ];
  }) ];

  installPhase = ''
    runHook preInstall
    install -Dm755 tern "$out/bin/tern"
    runHook postInstall
  '';

  # These libraries are loaded with dlopen, so autoPatchelf cannot discover them.
  postFixup = ''
    wrapProgram "$out/bin/tern" \
      --prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath [
        wayland libxkbcommon libGL vulkan-loader libxcb
        pipewire libpulseaudio pam webkitgtk_4_1
      ]}
  '';

  meta = {
    description = "Stencil's native terminal";
    homepage = "https://stencil.so/tern";
    license = lib.licenses.unfree;
    platforms = [ "x86_64-linux" ];
    mainProgram = "tern";
  };
}
