{ ... }:

{
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Wine applications can require 32-bit graphics drivers.
  hardware.graphics.enable32Bit = true;

  services.xserver = {
    enable = false;
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  services.displayManager = {
    defaultSession = "plasma";
    sddm = {
      enable = true;
      wayland.enable = true;
    };
  };
  services.desktopManager.plasma6.enable = true;
  services.fprintd.enable = true;
  # SDDM includes the login PAM stack. KWallet needs the login password.
  security.pam.services.login = {
    fprintAuth = false;
    kwallet.enable = true;
  };
  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  programs.firefox.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "nop" ];
  };
}
