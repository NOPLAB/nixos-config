{ pkgs }:

pkgs.mkShell {
  packages = with pkgs; [
    gnumake
    python3
    ghostscript
    poppler-utils
    (texlive.combine {
      inherit (texlive)
        scheme-small
        collection-latexrecommended
        collection-fontsrecommended
        collection-pictures
        collection-langjapanese
        ipaex
        latexmk
        texcount
        ;
    })
  ];
}
