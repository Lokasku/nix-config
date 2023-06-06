{ pkgs, lib, config, options, ... }:
{
  home.username = "luke";
  home.homeDirectory = "/home/luke";
  home.stateVersion = "22.11";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    alacritty
    firefox
    git
    fish
    dmenu
    neofetch
    starship
    feh
    imagemagick

    ghc
    cabal-install
    haskellPackages.xmobar

    cargo

    flameshot
  ];

  programs.alacritty.enable = true;
  programs.firefox.enable = true;
  programs.git = {
    aliases = {
      c = "commit -m";
      a = "add";
      ps = "push";
      pl = "pull";
      co = "checkout";
      cl = "clone";
    };
    enable = true;
    userEmail = "lukasku@proton.me";
    userName = "Lokasku";
  };
  programs.vim.enable = true;
  programs.fish.enable = true;
  programs.starship.enable = true;
  programs.feh.enable = true;  
  gtk = {
    enable = true;
    theme = {
      name = "Materia-dark";
      package = pkgs.materia-theme;
    };
  };
}
