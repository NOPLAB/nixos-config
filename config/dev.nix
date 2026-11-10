{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    gh
    neovim
    curl

    fnm
    pnpm

    rustup
    cargo

    probe-rs-tools
  ];
}
