{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    gh
    neovim
    tree-sitter
    gcc
    curl

    fnm
    pnpm

    rustup
    cargo

    probe-rs-tools
  ];
}
