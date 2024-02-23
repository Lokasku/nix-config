{ pkgs, lib, ... }:

with lib; {
  programs.zellij = {
      enableFishIntegration = true;
      settings = {
          theme = "Tokyo Night";
      };
 };
}
