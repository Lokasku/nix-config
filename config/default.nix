{ pkgs, ... }:

{
  imports = [
    ./neovim.nix
    ./alacritty.nix
    ./git.nix
  ];
}
