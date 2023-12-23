{ lib, pkgs, ... }:

with lib;
{
  xsession.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
    config = ./xmonad.hs;
    haskellPackages = pkgs.haskell.packages.ghc948;
  };
}
