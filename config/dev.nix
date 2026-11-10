{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    gh
    neovim
    tree-sitter
    gcc
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
  ];
}
