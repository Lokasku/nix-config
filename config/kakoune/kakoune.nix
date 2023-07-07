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
  kak-rainbow = pkgs.kakouneUtils.buildKakounePluginFrom2Nix rec {
    pname = "kak-rainbow";
    version = "1.0.0";
    src = pkgs.fetchFromGitHub {
      owner = "Bodhizafa";
      repo = "kak-rainbow";
      rev = "9c3d0aa62514134ee5cb86e80855d9712c4e8c4b";
      sha256 = "sha256-ryYq4A89wVUsxgvt4YqBPXsTFMDrMJM6BDBEHrWHD1c=";
    };

    postInstall = ''
      mkdir -p $out/lib
      mv $out/share/kak/autoload/plugins/${pname}/rainbow.kak $out/lib
      cat >$out/share/kak/autoload/plugins/${pname}/rainbow.kak <<EOF
        provide-module rainbow %{
          source $out/lib/rainbow.kak
        }
      EOF
    '';
  };
in
  with lib;
  {
    home.packages = with pkgs; [
      haskell-language-server # Haskell LSP
      rust-analyzer           # Rust    LSP
      rnix-lsp                # Nix     LSP
    ];
    programs.kakoune = {
      plugins = with pkgs.kakounePlugins; [
        kak-lsp
        fzf-kak
        kak-rainbow
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
