{ pkgs, ... }:

{
  virtualisation.docker.enable = true;

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

    nodejs
    bun
    fnm
    pnpm

    uv

    rustup
    cargo

    probe-rs-tools

  ];
}
