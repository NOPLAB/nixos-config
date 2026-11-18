{ ... }:

{
  # PlasmaはBluetoothが有効な場合に設定画面とトレイを追加する。
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

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

  # Use SSD swap only after the higher-priority zram swap.
  swapDevices = [{
    device = "/swapfile";
    size = 16 * 1024; # MiB
    priority = 0;
  }];

  services.fwupd.enable = true;
}
