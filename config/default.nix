{ pkgs, ... }:

{
  imports = [
    ./xmonad

    ./alacritty.nix
    ./git.nix
    ./fish.nix
    ./starship.nix
    ./redshift.nix
    ./picom.nix
    ./mpv.nix
    ./kakoune/kakoune.nix
    ./gtk.nix
    ./rofi.nix
    ./polybar.nix
    ./direnv.nix
  ];
}
