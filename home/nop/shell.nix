{ ... }:

{
  programs.fish.enable = true;
  programs.tmux = {
    enable = true;
    extraConfig = builtins.readFile ../../dotfiles/tmux.conf;
  };
}
