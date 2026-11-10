{ pkgs, inputs, ... }:

let
  agents = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system};
in

{
  home.username = "nop";
  home.homeDirectory = "/home/nop";

  home.packages = [
    pkgs.cowsay
    pkgs.xeyes

    agents.claude-code
    agents.codex
  ];

  home.stateVersion = "26.05";
  programs.home-manager.enable = true;
}
