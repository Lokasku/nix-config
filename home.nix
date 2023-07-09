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

        # Haskell Packages
        haskellPackages.xmonad
        haskellPackages.xmobar

      # Rust
      cargo

      # Misc
      (pkgs.callPackage ./config/pragmata.nix {})
      dmenu
      neofetch
      imagemagick
      brightnessctl # light controler
      discord
      spotify
      xfce.thunar
    ];
    
    sessionVariables.EDITOR = "kak";
  };

  xsession = {
    enable = true;
  };

  programs = {
    broot.enable = true;
    kakoune.enable = true;
    mpv.enable = true;
    yt-dlp.enable = true;
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
    redshift.enable = true;
    picom.enable = true;
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
