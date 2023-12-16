{ lib, pkgs, ... }:

with lib;
{
  programs.vscode = {
    enableExtensionUpdateCheck = true;
    extensions = with pkgs; [
      vscode-extensions.jnoortheen.nix-ide
      vscode-extensions.haskell.haskell
      vscode-extensions.github.github-vscode-theme
    ];
  };
}
