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
    vim.enable = true;
    alacritty.enable = true;
    firefox.enable = true;
    git = {
      enable = true;
      aliases = {
        c = "commit -m";
        a = "add";
        ps = "push";
        pl = "pull";
        co = "checkout";
        cl = "clone";
      };
      userEmail = "lukasku@proton.me";
      userName = "Lokasku";
    };
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
