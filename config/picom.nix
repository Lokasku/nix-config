{ lib, pkgs, ... }:

with lib; {
  services.picom = {
    backend = "glx";
    settings = {
      round-borders = 1;

      blur = {
        method = "kawase";
        background = false;
        background-frame = false;
        background-fixed = false;
      };
    };
  };
}
