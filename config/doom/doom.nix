/* { lib, pkgs, ... }:

{
    programs.emacs = {
        extraConfig = "";
        extraPackages = epkgs: [ epkgs.doom epkgs.doom-themes ];
    };

    home.file.".emacs.d" = {
        source = ./emacs;
        recursive = true;
    };
} */

{ pkgs, ... }:

let
  doom-emacs = pkgs.callPackage (builtins.fetchTarball {
    url = https://github.com/nix-community/nix-doom-emacs/archive/master.tar.gz;
  }) {
    doomPrivateDir = ./doom;
  };
in {
  home.packages = [ doom-emacs ];
}
