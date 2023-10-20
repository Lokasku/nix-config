{ lib, pkgs, ... }:

with lib; {
  programs.mpv = {
    config = {
      profile = "gpu-hq";
      force-window = true;
      ytdl-format = "bestvideo+bestaudio";
    };
    defaultProfiles = [ "gpu-hq" ];
  };
}
