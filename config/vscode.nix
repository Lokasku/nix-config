{ lib, pkgs, ... }:

with lib;
{
  programs.vscode = {
    enableExtensionUpdateCheck = true;
    enableUpdateCheck = true;
    extensions = with pkgs; [
      vscode-extensions.jnoortheen.nix-ide
      vscode-extensions.haskell.haskell
      vscode-extensions.github.github-vscode-theme
      vscode-extensions.bradlc.vscode-tailwindcss
    ];
  };
}
