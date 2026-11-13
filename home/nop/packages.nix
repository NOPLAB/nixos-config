{ lib, osConfig, pkgs, inputs, ... }:

let
  agents = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system};
  # Use newer desktop packages pinned by llm-agents in flake.lock:
  # Linux ChatGPT support and WinBoat with a supported Electron version.
  desktopPkgs = import inputs.llm-agents.inputs.nixpkgs {
    system = pkgs.stdenv.hostPlatform.system;
    config.allowUnfree = true;
  };
in

{
  home.packages = [
    pkgs.btop
    pkgs.dust
    pkgs.cowsay

    agents.claude-code
    agents.codex
    agents.omo-ai
  ] ++ lib.optionals osConfig.profiles.desktop.enable [
    pkgs.xeyes
    pkgs.discord
    pkgs.slack
    pkgs.spotify
    pkgs.obsidian
    (pkgs.callPackage ../../pkgs/bottles.nix { })
    desktopPkgs.winboat
    desktopPkgs.chatgpt
    (agents.claude-desktop.override {
      commandLineArgs = "--ozone-platform-hint=auto --enable-wayland-ime";
    })
    (pkgs.callPackage ../../pkgs/tern.nix { })
  ];
}
