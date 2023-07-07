{ lib, pkgs, ... }:

let
  kakship = pkgs.kakouneUtils.buildKakounePluginFrom2Nix rec {
    pname = "kakship";
    version = "";
    src = pkgs.fetchFromGitHub {
      owner = "eburghar";
      repo = "kakship";
      rev = "c58d592051d65d004129185c5f0bb48c11a63801";
      sha256 = "sha256-JYw1HyYC7G9/gGa8ne8smWx02z79v7XiVmIDC9BXD48=";
    };
  };
  kakrc = pkgs.writeTextFile rec {
    name = "kakrc.kak";
    destination = "/share/kak/autoload/${name}";
    text = builtins.readFile ./kakrc;
  };
in
  with lib;
  {
    home.packages = with pkgs; [
      haskell-language-server # Haskell LSP
      rust-analyzer           # Rust    LSP
      rnix-lsp                # Nix     LSP

      guile                   # Needed by kakoune-rainbow
    ];
    programs.kakoune = {
      plugins = with pkgs.kakounePlugins; [
        kak-lsp
        fzf-kak
        kakoune-rainbow
        kakship

        kakrc
      ];
      config = {
        # autoInfo = null;
        autoReload = "ask";
        incrementalSearch = true;
        numberLines = {
          enable = true;
        };
        scrollOff = {
          columns = 15;
          lines = 15;
        };
      };
    };

    xdg.configFile."kak-lsp/kak-lsp.toml".source = ./kak-lsp.toml;
  }
