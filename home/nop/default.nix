{ ... }:

{
  imports = [
    ./packages.nix
    ./shell.nix
    ./neovim.nix
  ];

  home.username = "nop";
  home.homeDirectory = "/home/nop";
  home.stateVersion = "26.05";
  programs.home-manager.enable = true;
}
