{ config, pkgs, inputs, lib, ... }:

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
