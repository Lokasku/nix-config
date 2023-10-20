{ pkgs, lib, ... }:

with lib; {
  programs.git = {
    aliases = {
      c = "commit -m";
      a = "add";
      ps = "push";
      pl = "pull";
      co = "checkout";
      cl = "clone";
      b = "branch";
    };
    userEmail = "lukasku@proton.me";
    userName = "Loqasku";
    delta.enable = true;
    ignores = [ "*.swp" ];
  };
}
