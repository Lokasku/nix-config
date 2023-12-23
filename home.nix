{ pkgs, lib, ... }:

with lib;
{
  nixpkgs.config.allowUnfree = true;

  imports = [
    ./config
  ];

  home = {
    username = "lokasku";
    homeDirectory = "/home/lokasku";
    stateVersion = "23.11";
    packages = with pkgs; [
      # Rust   Lisp   Haskell
      cargo    sbcl   ghc
                      cabal-install

      #=- XMonad
      haskellPackages.xmonad
      haskellPackages.xmobar

      #=- Matrix
      element-desktop

      #=- Minecraft
      jre8
      prismlauncher-qt5

      #=- Font
      (pkgs.callPackage ./config/pragmata.nix {})
      (nerdfonts.override {
        fonts = ["Iosevka" "MPlus"];
      })
      mplus-outline-fonts.githubRelease

      #=- Misc
      dmenu
      neofetch
      brightnessctl
      firefox
      nasm
    ];
    
    sessionVariables.EDITOR = "kak";
  };

  xsession = {
    enable = true;
  };

  fonts.fontconfig.enable = true;

  programs = {
    kakoune.enable = true;
    mpv.enable = true;
    home-manager.enable = true;
    alacritty.enable = true;
    firefox.enable = true;
    git.enable = true;
    fish.enable = true;
    starship.enable = true;
    feh.enable = true;
    direnv.enable = true;
  };

  services = {
    redshift.enable = true;
    picom.enable = true;
    flameshot.enable = true;
    polybar.enable = true;
  };
}
