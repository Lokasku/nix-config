{ pkgs, lib, ... }:

with lib;
{
  nixpkgs.config.allowUnfree = true;

  imports = [
    ./config
  ];

  home = {
    username = "lukasku";
    homeDirectory = "/home/lukasku";
    stateVersion = "22.11";
    packages = with pkgs; [
      # Haskell
      ghc cabal-install ormolu

        # Haskell Packages
        haskellPackages.xmonad
        haskellPackages.xmobar

      # Rust
      cargo

      # Lisp
      sbcl

      # NodeJS
      nodejs_20

      # Security
      openvpn
      nmap
      inetutils
      redis
      gobuster
      openssh

      # Misc
      (pkgs.callPackage ./config/pragmata.nix {})
      dmenu
      neofetch
      brightnessctl # light controler
      libsForQt5.dolphin
      unzip
      (nerdfonts.override {
        fonts = ["Iosevka" "MPlus"];
      })
      mplus-outline-fonts.githubRelease
      discord
      libreoffice
      nitch
    ];
    
    sessionVariables.EDITOR = "kak";
  };

  xsession = {
    enable = true;
  };

  fonts.fontconfig.enable = true;

  programs = {
    vscode.enable = true;
    broot.enable = true;
    kakoune.enable = true;
    mpv.enable = true;
    home-manager.enable = true;
    alacritty.enable = true;
    firefox.enable = true;
    git.enable = true;
    fish.enable = true;
    starship.enable = true;
    feh.enable = true;
    neovim.enable = true;
    irssi.enable = true;
    direnv.enable = true;
    zathura.enable = true;
    rofi.enable = false;
  };

  services = {
    redshift.enable = true;
    picom.enable = true;
    flameshot.enable = true;
    polybar.enable = true;
  };
}
