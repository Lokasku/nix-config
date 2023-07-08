{ lib, pkgs, ... }:

let
  /* kakship = pkgs.kakouneUtils.buildKakounePluginFrom2Nix rec {
    pname = "kakship";
    version = "";
    src = pkgs.fetchFromGitHub {
      owner = "eburghar";
      repo = "kakship";
      rev = "c58d592051d65d004129185c5f0bb48c11a63801";
      sha256 = "sha256-JYw1HyYC7G9/gGa8ne8smWx02z79v7XiVmIDC9BXD48=";
    };
  }; */
  kakship' = pkgs.rustPlatform.buildRustPackage rec {
    pname = "kakship";
    version = "0.2.8";
    src = pkgs.fetchFromGitHub {
      owner = "mesabloo";
      repo = "kakship";
      rev = "937d904a893daf59f70dc955e60209cd8866a7c3";
      sha256 = "1pk0v0b31bppjzl08qgrjld40pc7rqc257zzgdl4r8zaamqsmkz9";
    };
    cargoLock = {
      lockFile = "${src}/Cargo.lock";
      outputHashes = {
        "kak-0.1.2" = "sha256-RhtHQkC9yCSJtr/kbC5c9MavbL79acrsiEGXyoAST8U=";
        "yew-ansi-0.1.0" = "sha256-dSaEzqiOon+OqCZKQudzLRNP+Iv97kC+XZcTElKNrzs=";
      };
    };

    # patchPhase = ''
    #   substituteInPlace src/main.rs \
    #     --replace '"starship"' "\"${pkgs.starship}/bin/starship\""
    # '';

    postInstall = ''
      # Copy rc files to /share/kak/autoload
      mkdir -p $out/share/kak/autoload/plugins/${pname}
      cp $src/rc/*.kak $out/share/kak/autoload/plugins/${pname}
    '';
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

      starship
    ];
    programs.kakoune = {
      plugins = with pkgs.kakounePlugins; [
        kak-lsp
        fzf-kak
        kak-rainbow
        kakship'

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

    xdg.configFile."kak/starship.toml".source = ./starship.toml;
    xdg.configFile."kak-lsp/kak-lsp.toml".source = ./kak-lsp.toml;
  }
