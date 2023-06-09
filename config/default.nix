{ pkgs, ... }:

{
  imports = [
    ./neovim.nix
    ./alacritty.nix
    ./git.nix
    ./fish.nix
    ./starship.nix
  ];
}
