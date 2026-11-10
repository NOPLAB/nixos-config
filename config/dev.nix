{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    gh
    neovim
    tree-sitter
    gcc
    gnumake
    curl
    ripgrep
    unzip
    lua-language-server
    stylua

    fnm
    pnpm

    uv

    rustup
    cargo

    probe-rs-tools

    # RSJ manuscript build and submission checks.
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
