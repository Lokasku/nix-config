{ pkgs, lib, ... }:

with lib; {
  programs.starship.settings = {
    format = lib.strings.concatStrings [
      "$character"
      # "$hostname"
      # "$username"
      "$directory"
      "$git_branch"
      "$haskell"
      "$c"
      "$rust"
      "$nix_shell"
    ];
    add_newline = false;
    character = {
      success_symbol = "[λ](red) 〉";
      error_symbol = "[λ](red) 〉";
    };
    /* hostname = {
      ssh_only = false;
      format = "\\\([$hostname]($style)";
      style = "purple";
    };
    username = {
      style_user = "white";
      style_root = "white italic";
      format = ":[$user]($style)\\\) ";
      show_always = true;
    }; */
    directory = {
      truncate_to_repo = true;
      format = "[$path]($style) [$read_only]($read_only_style) 〉 ";
      style = "fg:#B5B5B5";
      read_only = "ro";
      read_only_style = "italic";
    };
    haskell = {
      format = "[$symbol](fg:#8577BB) [$version](fg:#A366BF) 〉 ";
      detect_files = ["Main.hs" "Config.hs" "stack.yaml" "cabal.project"];
      symbol = "H";
    };
    c = {
      format = "[$symbol](fg:#888888) [$version](fg:#AEAEAE) 〉";
      symbol = "C";
    };
    rust = {
      format = "[$symbol](fg:#FF8740) [$version](fg:#FD9D5F) 〉";
      symbol = "R";
    };
    /* custom.lisp = {
      format = "[$symbol](fg:cyan) [$state](fg:#C4C4C4):[$name](fg:#B1B1B1)\) ";
      symbol = "L";
      detect_extensions = ["lisp" "cl" "rkt" "clj" "ss"];
    }; */
    nix_shell = {
      format = "[$symbol](fg:cyan) [$state](fg:#C4C4C4):[$name](fg:#B1B1B1) 〉";
      symbol = "NS";
    };
  };
}
