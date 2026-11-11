{ pkgs, ... }:

{
  boot.loader = {
    systemd-boot = {
      enable = true;
      # The 96 MiB ESP is shared with Windows; two initrds do not fit.
      configurationLimit = 1;
    };
    efi.canTouchEfiVariables = true;
  };

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
  };

  services.fwupd.enable = true;
  environment.systemPackages = with pkgs; [
    vim
    wget
  ];
}
