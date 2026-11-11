{ ... }:

{
  imports = [
    ./system.nix
    ./networking.nix
    ./desktop.nix
    ./locale.nix
    ./users.nix
    ./nix.nix
    ./development.nix
    ./fonts.nix
  ];
}
