{ config, lib, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs;
    [
      git
      lazygit
      gh

      vim
      neovim
      vscode

      fnm
      pnpm

      rustup
      cargo

      stm32cubemx
      probe-rs-tools

      claude-code
    ];
}
