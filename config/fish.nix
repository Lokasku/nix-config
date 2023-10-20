{ lib, pkgs, ... }:

with lib; {
  programs.fish = {
    shellAbbrs = {
      en = "cd /etc/nixos";
      hmc = "cd ~/.config/nixpkgs";
      update = "nix-env -u";
    };
    shellAliases = {
      c = "cargo";
      g = "git";
      n = "nix";
    };
  };
}
