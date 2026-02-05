{ config, lib, pkgs, ... }:

{
  fonts = {
   packages = (with pkgs;
      [
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
        terminus_font
        cantarell-fonts
      ]
    );
    fontDir.enable = true;
    fontconfig = {
      defaultFonts = {
        serif = [
          "Noto Serif CJK JP"
          "Noto Color Emoji"
        ];
        sansSerif =[
          "Noto Sans CJK JP"
          "Noto Clor Emoji"
        ];
        emoji = ["Noto Color Emoji"];
      };
    };
  };

  # inputMethod
  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5.waylandFrontend = true;
    fcitx5.addons = with pkgs;[
      fcitx5-mozc
      fcitx5-gtk
    ];
  };

  services.xserver.exportConfiguration = true;
}
