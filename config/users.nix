{ pkgs, ... }:

{
  users.users.nop = {
    isNormalUser = true;
    description = "nop";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = [ pkgs.kdePackages.kate ];
  };
}
