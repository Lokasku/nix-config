{ lib, pkgs, ... }:

with lib;
{
  programs.broot = {
    enableFishIntegration = true;
    #  settings.skin = {}
  };
}
