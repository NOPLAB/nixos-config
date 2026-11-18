{ lib, appimageTools, fetchurl }:

let
  pname = "solidcraft";
  version = "0.44.1";
  src = fetchurl {
    url = "https://github.com/tangency-labs/solidcraft/releases/download/v${version}/solidcraft-${version}-linux-x86_64.AppImage";
    sha256 = "6e472bd7f557a3c0564e4548c460b1b84d906237c68af327e57d946b13e51cf4";
  };
  contents = appimageTools.extractType2 { inherit pname version src; };
in
appimageTools.wrapType2 {
  inherit pname version src;

  extraInstallCommands = ''
    install -Dm644 ${contents}/io.tangencylabs.solidcraft.desktop \
      $out/share/applications/io.tangencylabs.solidcraft.desktop
    cp -r ${contents}/usr/share/icons $out/share/icons
    cp -r ${contents}/usr/share/mime $out/share/mime
    substituteInPlace $out/share/applications/io.tangencylabs.solidcraft.desktop \
      --replace-fail 'Exec=solidcraft %f' "Exec=$out/bin/solidcraft %f" \
      --replace-fail 'TryExec=solidcraft' "TryExec=$out/bin/solidcraft"
  '';

  meta = {
    description = "Parametric 3D CAD";
    homepage = "https://solidcraft.io";
    platforms = [ "x86_64-linux" ];
    mainProgram = "solidcraft";
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
  };
}
