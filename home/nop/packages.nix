{ lib, osConfig, pkgs, inputs, ... }:

let
  agents = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system};
  # Use newer desktop packages pinned by llm-agents in flake.lock:
  # Linux ChatGPT, supported WinBoat Electron, and Office-capable Bottles.
  desktopPkgs = import inputs.llm-agents.inputs.nixpkgs {
    system = pkgs.stdenv.hostPlatform.system;
    config.allowUnfree = true;
  };
  officeBottles = desktopPkgs.callPackage ../../pkgs/bottles.nix { };
  officeApps = [ "Word" "Excel" "PowerPoint" "Outlook" "OneNote" "Access" "Publisher" ];
in

{
  home.packages = [
    pkgs.btop
    pkgs.dust
    pkgs.cowsay

    agents.claude-code
    agents.codex
    agents.antigravity-cli
    agents.omo-ai
  ] ++ lib.optionals osConfig.profiles.desktop.enable [
    pkgs.xeyes
    pkgs.discord
    pkgs.slack
    pkgs.spotify
    pkgs.obsidian
    (pkgs.callPackage ../../pkgs/solidcraft.nix { })
    officeBottles
    desktopPkgs.winboat
    desktopPkgs.chatgpt
    (agents.claude-desktop.override {
      commandLineArgs = "--ozone-platform-hint=auto --enable-wayland-ime";
    })
    (pkgs.callPackage ../../pkgs/tern.nix { })
  ];

  xdg.desktopEntries = lib.mkIf osConfig.profiles.desktop.enable (
    builtins.listToAttrs (map (app: {
      name = "microsoft-365-${lib.toLower app}";
      value = {
        name = "Microsoft ${app}";
        exec = ''${officeBottles}/bin/bottles-cli run -b Microsoft-365 -p "Microsoft ${app}"'';
        icon = "applications-office";
        categories = [ "Office" ];
        terminal = false;
      };
    }) officeApps)
  );
}
