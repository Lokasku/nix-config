{ lib, pkgs, ... }:

with lib;
{
  gtk = {
    enable = true;
    theme = {
      name = "White Sur";
      package = pkgs.whitesur-gtk-theme;
    };
    cursorTheme = {
        package = pkgs.apple-cursor;
        size = 20;
        name = "macOS-BigSur-White";
    };
  };
}
