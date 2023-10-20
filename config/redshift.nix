{ lib, pkgs, ... }:

with lib; {
  services.redshift = {
    provider = "geoclue2";
  };
}
