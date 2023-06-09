{ pkgs, lib, ... }:

with lib;
{
  nixpkgs.config.allowUnfree = true;

  imports = [
    ./config
  ];

  home = {
    username = "luke";
    homeDirectory = "/home/luke";
    stateVersion = "22.11";
    packages = with pkgs; [
      # Haskell
      ghc cabal-install

      # Rust
      cargo

      # Misc
      dmenu
      neofetch
      imagemagick
    ];
  };

  programs = {
    home-manager.enable = true;
    alacritty.enable = true;
    firefox.enable = true;
    git.enable = true;
    fish.enable = true;
    starship.enable = true;
    feh.enable = true;
    neovim.enable = true;
  };

  services = {
    flameshot.enable = true;
  };

  gtk = {
    enable = true;
    theme = {
      name = "Materia-dark";
      package = pkgs.materia-theme;
    };
  };
}
