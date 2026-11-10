{ config, lib, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs;
    [
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
