{ lib, pkgs, ... }:

with lib;
{
  programs.alacritty = {
    settings = {
      window = {
        dynamic_padding = true;
        decorations = "none";
        opacity = 0.5;
        startup_mode = "Maximized";
        title = "Alacritty";
      };
      font = {
        normal = {
          family = "Pragmata Pro";
          style = "Regular";
        };
        bold.style = "Bold";
        italic.style = "Italic";
        bold_italic.style = "Bold Italic";
        size = 7.0;
        offset = {
          x = 0;
          y = 2;
        };
        glyph_offset = {
          x = 0;
          y = 2;
        };
      };
      colors = {
        primary = {
          background = "#1c1c1e";
          foreground = "#f2f2f7";
        };
        normal = {
          black = "#000000";
          red = "#ff6961";
          green = "#31de4b";
          yellow = "#ffd423";
          blue = "#409cff";
          magenta = "#da8fff";
          cyan = "#70d7ff";
          white = "#d9d9d9";
        };
        bright = {
          black = "#363636";
          red = "#ff4747";
          green = "#53e264";
          yellow = "#f4ef11";
          blue = "#76caf6";
          magenta = "#ff98f2";
          cyan = "#74f4ef";
          white = "#c7c7d6";
        };
        trasparent_background_colors = true;
      };
    };
  };
}
