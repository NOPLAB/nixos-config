{ ... }:

{
  programs.fish.enable = true;
  programs.direnv = {
    enable = true;
    enableFishIntegration = true;
    nix-direnv.enable = true;
  };
  programs.tmux = {
    enable = true;
    extraConfig = builtins.readFile ../../dotfiles/tmux.conf;
  };
}
