{ lib, pkgs, ... }:

with lib; {
  services.picom = {
    backend = "glx";
    settings = {
      round-borders = 1;

      blur = {
        method = "dual_kawase";
        background = false;
        background-frame = false;
        background-fixed = false;
      };
      blur-exclude = ["class_g != 'polybar'"];
    };
  };
}
