{ pkgs, ... }:

{
  programs.fish.enable = true;

  users.users.nop = {
    isNormalUser = true;
    description = "nop";
    shell = pkgs.fish;
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = [ pkgs.kdePackages.kate ];
  };
}
