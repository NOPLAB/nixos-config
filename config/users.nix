{ pkgs, ... }:

{
  programs.fish.enable = true;

  users.users.nop = {
    isNormalUser = true;
    description = "nop";
    shell = pkgs.fish;
    extraGroups = [ "networkmanager" "wheel" ];
    packages = [ pkgs.kdePackages.kate ];
  };
}
