{ config, pkgs, inputs, lib, ... }:

let
  agents = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system};
  # The system's 26.05 package only supports macOS. Use the Linux package
  # from the newer nixpkgs already pinned by llm-agents in flake.lock.
  desktopPkgs = import inputs.llm-agents.inputs.nixpkgs {
    system = pkgs.stdenv.hostPlatform.system;
    config.allowUnfree = true;
  };
in

{
  home.username = "nop";
  home.homeDirectory = "/home/nop";

  home.packages = [
    pkgs.cowsay
    pkgs.xeyes
    pkgs.discord
    pkgs.slack
    desktopPkgs.chatgpt
    (pkgs.callPackage ./pkgs/claude-desktop.nix { })
    (pkgs.callPackage ./pkgs/tern.nix { })

    agents.claude-code
    agents.codex
    agents.omo-ai
  ];

  home.stateVersion = "26.05";
  programs.fish.enable = true;
  programs.tmux = {
    enable = true;
    extraConfig = builtins.readFile ./dotfiles/tmux.conf;
  };

  xdg.configFile."nvim" = {
    source = ./dotfiles/nvim;
    recursive = true;
  };

  # lazy.nvim needs a writable lockfile for plugin updates.
  home.activation.seedNeovimLockfile = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    lockfile="${config.xdg.dataHome}/nvim/lazy-lock.json"
    if [ ! -e "$lockfile" ]; then
      run mkdir -p "${config.xdg.dataHome}/nvim"
      run install -m 644 ${./dotfiles/nvim/lazy-lock.json} "$lockfile"
    fi
  '';
  programs.home-manager.enable = true;
}
