{ lib, pkgs, ... }:

with lib;
{
  services.polybar = {
    script = "polybar top &";
    package = pkgs.polybar.override {
      alsaSupport = true;
      pulseSupport = true;
    };
    config = {
      "colors" = {
        white = "aaffffff";
        black = "aa1c1c1e";
        gray = "aa8e8e93";

        green4 = "aa31bb4f";
        green3 = "aa38c758";
        green2 = "aa43d565";
        green1 = "aa4ee371";

        orange = "aaff9500";
        orange1 = "aaff6861";
        orange2 = "aaffb33f";
        orange3 = "aaffd426";
        orange4 = "aa32de4b";
      };
      "bar/top" = {
        monitor = "\${env:MONITOR:}";

        width = "100%";
        height = "31";

        radius = 0;

        modules-left = "ewmh";
        modules-center = "title";
        modules-right = "cpu barsep ram barsep wlan barsep sep battery sep volume sep date sep";

        font-0 = "Pragmata Pro:size=10";
        font-1 = "M+1 Nerd Font:style=Medium:size=11";

        background = "\${colors.black}";
        foreground = "\${colors.white}";
      };
      "module/sep" = {
        type = "custom/text";
        content = " ";
        # content-font = 1;
      };
      "module/barsep" = {
        type = "custom/text";
        content = "󰿟";
        content-foreground = "\${colors.gray}";
      }; 
      "module/date" = {
        type = "internal/date";
        internal = 5;

        date = "%d.%m.%y";
        time = "%H:%M";
        label = "%date% %time%";

        label-active-font = 1;
      };
      "module/title" = {
        type = "internal/xwindow";

        format = "<label>";
        format-foreground = "\${colors.white}";

        label = "%title%";
        label-empty = "";
      };
      "module/volume" = {
        type = "internal/pulseaudio";

        use-ui-max = false;

        interval = 4;

        format-volume = "<ramp-volume><label-volume>";
        format-muted = "<label-muted>";
        format-volume-padding = 1;
        format-muted-padding = 1;

        label-muted = "";
        label-muted-foreground = "\${colors.white}";

        label-volume = "%percentage:3:3%%";
        label-volume-foreground = "\${colors.white}";

        ramp-volume-0 = "";
        ramp-volume-0-foreground = "\${colors.white}";

        ramp-volume-1 = "";
        ramp-volume-1-foreground = "\${colors.white}";

        ramp-volume-2 = "";
        ramp-volume-2-foreground = "\${colors.white}";

        label-volume-0-foreground = "\${colors.white}";
      }; 
      "module/ewmh" = rec {
        type = "internal/xworkspaces";

        pin-workspaces = false;
    
        enable-click = false;
        enable-scroll = false;
        
        format = " <label-state>";
        format-foreground = "\${colors.gray}";
        format-padding = 1;
        # format-font = 3;

        label-active = "%icon% ";
        label-active-foreground = "\${colors.white}";
        label-active-padding = 1;

        label-occupied = label-active;
        label-occupied-padding = label-active-padding;
        label-occupied-foreground = "\${colors.gray}";
    
        label-urgent = label-active;
        label-urgent-foreground = "#aa1c1c1e";
        label-urgent-padding = label-active-padding;
        
        label-empty = label-active;
        label-empty-foreground = "\${colors.gray}";
        label-empty-padding = label-active-padding;

        icon-0 = "music;·";
        icon-1 = "dev;";
        icon-2 = "www;·";
        icon-3 = "work;·";
        icon-default = "·";
      };
      "module/battery" = rec {
        type = "internal/battery";

        full-at = 100;
        low-at = 20;
        poll-interval = 5;

        # format-discharging = "<ramp-capacity> <label-discharging>";
        format-discharging = "<ramp-capacity>";
        # format-full = "<ramp-capacity> <label-full>";
        format-full = "<ramp-capacity>";
        format-charging = "<label-charging>";
        format-charging-padding = 1;
        format-discharging-padding = format-charging-padding;
        format-full-padding = format-charging-padding;
        
        label-charging = "󱐋 %percentage:3:3%%";
        # label-charging-foreground = "\${colors.nord15}";
        label-discharging = "%percentage:3:3%%";
        label-full = "100%";
        label-warn = label-discharging;
        # label-warn-foreground = "\${colors.nord11}";

        ramp-capacity-0 = "";
        ramp-capacity-0-foreground = "\${colors.white}";
        ramp-capacity-1 = "";
        ramp-capacity-1-foreground = "\${colors.white}";
        ramp-capacity-2 = "";
        ramp-capacity-2-foreground = "\${colors.white}";
        ramp-capacity-3 = "";
        ramp-capacity-3-foreground = "\${colors.white}";
        ramp-capacity-4 = "";
        ramp-capacity-4-foreground = "\${colors.white}";
      };
      "module/cpu" = rec {
        type = "internal/cpu";
        
        interval = 1;
        
        # format = "  <ramp-coreload> <label>";
        format = "<label>";
        format-padding = 1;
    
        label = "%percentage:3:3%%";
        label-foreground = "\${colors.nord5}";

        ramp-coreload-spacing = 0;
        ramp-coreload-0 = "▁";
        ramp-coreload-0-foreground = "\${colors.orange4}";
        ramp-coreload-1 = "▂";
        ramp-coreload-1-foreground = ramp-coreload-0-foreground;
        ramp-coreload-2 = "▃";
        ramp-coreload-2-foreground = "\${colors.orange3}";
        ramp-coreload-3 = "▄";
        ramp-coreload-3-foreground = ramp-coreload-2-foreground;
        ramp-coreload-4 = "▅";
        ramp-coreload-4-foreground = "\${colors.orange2}";
        ramp-coreload-5 = "▆";
        ramp-coreload-5-foreground = ramp-coreload-4-foreground;
        ramp-coreload-6 = "▇";
        ramp-coreload-6-foreground = "\${colors.orange1}";
        ramp-coreload-7 = "█";
        ramp-coreload-7-foreground = ramp-coreload-6-foreground;
      };
      "module/ram" = rec {
        type = "internal/memory";
        
        interval = "0.5";
        
        # format = "󰍛 <bar-used> <label>";
        format = "<label>";
        format-padding = 1;
        
        label = "%percentage_used:3:3%%";
        label-foreground = "\${colors.white}";
        label-warn = label;
        label-warn-foreground = "\${colors.orange}";

        bar-used-indicator = "";
        bar-used-width = 10;
        bar-used-foreground-0 = "\${colors.green4}";
        bar-used-foreground-1 = "\${colors.green3}";
        bar-used-foreground-2 = "\${colors.green2}";
        bar-used-foreground-3 = "\${colors.green1}";
        bar-used-fill = "▐";
        bar-used-empty = "▐";
        bar-used-empty-foreground = "\${colors.gray}";
      };
      "module/wlan" = rec {
        type = "internal/network";

        interface = "\${env:WIFI_IF:}";
        interface-type = "wireless";

        interval = 5;

        format-connected = "<label-connected>";
        format-connected-padding = 1;
        format-disconnected = "<label-disconnected>";
        format-disconnected-padding = format-connected-padding;
        format-packetloss = "<label-packetloss>";
        format-packetloss-padding = format-connected-padding;
        
        label-connected = "󱚽";
        label-connected-foreground = "\${colors.nord14}";
        label-disconnected = "󰖪";
        label-disconnected-foreground = "\${colors.nord3}";
        label-packetloss = "󱚵";
        label-packetloss-foreground = "\${colors.nord11}";
      };
    };
  };
}
