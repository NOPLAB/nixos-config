{ config, pkgs, inputs, ... }:

{
  home.username = "nop";
  home.homeDirectory = "/home/nop";

  home.packages = [
    pkgs.cowsay
    pkgs.xeyes

    inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.claude-code
    inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.codex
  ];

  home.stateVersion = "26.05";
  programs.home-manager.enable = true;
}
