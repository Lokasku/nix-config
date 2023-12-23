{ lib, pkgs, ... }:

with lib; {
  programs.fish = {
    shellAbbrs = {
      en = "cd /etc/nixos";
      hmc = "cd ~/.config/home-manager";
      update = "nix-env -u";
    };
    shellAliases = {
      c = "cargo";
      g = "git";
      n = "nix";
    };
  };
}
