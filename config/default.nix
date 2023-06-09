{ pkgs, ... }:

{
  imports = [
    ./xmonad

    ./neovim.nix
    ./alacritty.nix
    ./git.nix
    ./fish.nix
    ./starship.nix
    ./redshift.nix
    ./picom.nix
    ./mpv.nix
    ./kakoune/kakoune.nix
    ./broot.nix
  ];
}
