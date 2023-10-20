{ lib, pkgs, ... }:

with lib;
{
    programs.rofi = {
        font = "Pragmata Pro";
        location = "bottom";
    };
}
