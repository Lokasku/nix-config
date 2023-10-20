{ lib, pkgs, ... }:

with lib; {
    programs.direnv = {
        nix-direnv.enable = true;
    };
}
