{ lib, pkgs, ... }:

let
  kakship = pkgs.rustPlatform.buildRustPackage rec {
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
  kks = pkgs.kakouneUtils.buildKakounePluginFrom2Nix rec {
    pname = "kks";
    version = "8113ea3";
    src = pkgs.fetchFromGitHub {
      owner = "kkga";
      repo = "kks";
      rev = "8113ea3bd718dec88b812faa1a41bacba0110fd7";
      sha256 = "sha256-/0ocgWArELGQkOZqbYRljPnzM/zQ9HCZq7gqhMD0Mq4=";
    };
  };
  kak-alacritty = pkgs.kakouneUtils.buildKakounePluginFrom2Nix rec {
    pname = "alacritty.kak";
    version = "30909bd";
    src = pkgs.fetchFromGitHub {
      owner = "Superty";
      repo = "alacritty.kak";
      rev = "30909bd89fa3804b31eb3cc91057e38af595a846";
      sha256 = "sha256-M3GN+0mhMIl7mgkqJ0j8TzyfI7ILFjdDUf+65uX094E=";
    };
  };
in
  with lib;
  {
    home.packages = with pkgs; [
      haskell-language-server # Haskell LSP
      rust-analyzer           # Rust    LSP
      rnix-lsp                # Nix     LSP

      kakship
    ];
    programs.kakoune = {
      plugins = with pkgs.kakounePlugins; [
        kak-lsp
        fzf-kak
        kak-rainbow
        kakship
        kks
        kak-alacritty

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
