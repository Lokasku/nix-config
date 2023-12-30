{ lib, pkgs, ... }:

with lib; {
  services.picom = {
    backend = "glx";
    settings = {
      round-borders = 0;

      blur = {
        method = "dual_kawase";
        background = false;
        background-frame = false;
        background-fixed = false;
        strength = 5;
      };
      # blur-exclude = ["class_g != 'polybar'"];
    };
  };
}
