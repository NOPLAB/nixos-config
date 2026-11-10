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

    stm32cubemx
    probe-rs-tools
  ];
}
