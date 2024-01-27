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
      # Rust   Haskell
      cargo    ghc cabal-install

      #=- XMonad
      haskellPackages.xmonad
      # haskellPackages.xmobar

      #=- Matrix
      element-desktop

      #=- Minecraft
      # jre8
      prismlauncher-qt5

      #=- Font
      (pkgs.callPackage ./config/pragmata.nix {})
      (nerdfonts.override {
        fonts = ["Iosevka" "MPlus" "Terminus"];
      })
      mplus-outline-fonts.githubRelease

      #=- Misc
      gcc
      gnumake
      yazi
      neofetch
      brightnessctl
      nasm
      binutils
      qemu
      figma-linux
    ];
    
    sessionVariables.EDITOR = "kak";
  };

  xsession = {
    enable = true;
  };

  fonts.fontconfig.enable = true;

  programs = {
    zathura.enable = true;
    zellij.enable = true;
    emacs.enable = false; # Emacs > *
    brave.enable = true;
    rofi.enable = true;
    # vscode.enable = false;
    kakoune.enable = true;
    mpv.enable = true;
    home-manager.enable = true;
    alacritty.enable = true;
    # firefox.enable = false;
    git.enable = true;
    fish.enable = true;
    starship.enable = true;
    feh.enable = true;
    direnv.enable = true;
  };

  services = {
    redshift.enable = true;
    picom.enable = false;
    flameshot.enable = true;
    polybar.enable = true;
  };
}
