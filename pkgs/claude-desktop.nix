{ lib, stdenv, fetchurl, dpkg, autoPatchelfHook, makeWrapper, wrapGAppsHook3
, alsa-lib, at-spi2-atk, at-spi2-core, atk, cairo, cups, dbus, expat
, glib, gtk3, libgbm, nspr, nss, pango, systemdLibs
, libx11, libxcb, libxcomposite, libxdamage, libxext, libxfixes
, libxrandr, libxkbcommon, libxtst, util-linux, libcap_ng, libseccomp
, libGL, libnotify, libsecret, pipewire, libpulseaudio, vulkan-loader
, libayatana-appindicator, xdg-utils, bubblewrap, socat, openssh
}:

stdenv.mkDerivation rec {
  pname = "claude-desktop";
  version = "4.23118.1";

  src = fetchurl {
    url = "https://downloads.claude.ai/claude-desktop/apt/stable/pool/main/c/claude-desktop/claude-desktop_${version}_amd64.deb";
    hash = "sha256-sJzN1ys4kWyWN9SFSNtw53xCXrLgm7RnRlQJ0v+dKHo=";
  };

  nativeBuildInputs = [ dpkg autoPatchelfHook makeWrapper wrapGAppsHook3 ];
  buildInputs = [
    stdenv.cc.cc.lib alsa-lib at-spi2-atk at-spi2-core atk cairo cups
    dbus expat glib gtk3 libgbm nspr nss pango systemdLibs
    libx11 libxcb libxcomposite libxdamage libxext libxfixes libxrandr
    libxkbcommon libxtst util-linux.lib libcap_ng libseccomp pipewire
  ];
  runtimeDependencies = [
    libGL libnotify libsecret pipewire libpulseaudio vulkan-loader
    libayatana-appindicator
  ];

  unpackPhase = ''
    runHook preUnpack
    # The Nix build sandbox cannot restore the upstream setuid sandbox helper.
    dpkg-deb --fsys-tarfile "$src" | tar -x \
      --no-same-owner --no-same-permissions --mode=u-s,g-s
    runHook postUnpack
  '';
  dontConfigure = true;
  dontBuild = true;
  dontStrip = true;
  dontWrapGApps = true;

  installPhase = ''
    runHook preInstall
    mkdir -p "$out"
    cp -r usr/lib usr/share "$out/"
    runHook postInstall
  '';

  postFixup = ''
    makeWrapper "$out/lib/claude-desktop/claude-desktop" "$out/bin/claude-desktop" \
      "''${gappsWrapperArgs[@]}" \
      --prefix PATH : ${lib.makeBinPath [ xdg-utils bubblewrap socat openssh ]} \
      --add-flags "--ozone-platform-hint=auto --enable-wayland-ime"
  '';

  meta = {
    description = "Official Claude desktop application";
    homepage = "https://claude.com/download";
    license = lib.licenses.unfree;
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
    platforms = [ "x86_64-linux" ];
    mainProgram = "claude-desktop";
  };
}
