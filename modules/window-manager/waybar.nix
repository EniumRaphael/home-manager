{
inputs,
config,
pkgs,
lib,
...
}:

let
  cfg = config.window-manager.waybar;
in
  {
  config = lib.mkIf cfg {
    home.packages = with pkgs; [
      nerd-fonts.fira-code
    ];
    programs.waybar = {
      enable = true;
      settings.mainBar = {
        layer = "top";
        position = "top";
        height = 42;
        output = [
          "DP-1"
          "HDMI-A-1"
        ];
        modules-left = [
          "custom/logo"
          "hyprland/workspaces"
        ];
        modules-center = [
          "clock"
          "custom/spacer"
          "cava"
        ];
        modules-right = [
          "cpu"
          "memory"
          "custom/gpu"
          "network"
          "tray"
          "pulseaudio"
          "battery"
          "custom/power"
        ];
        "custom/spacer" = {
          "format" = " | ";
        };
        tray = {
          spacing = 10;
        };
        cpu = {
          format = " {usage}%";
          tooltip = true;
          interval = 2;
        };
        network = {
          format = "";
          format-wifi = " {essid} ({signalStrength}%)";
          format-ethernet = "";
          tooltip-format-wifi = "{ipaddr}/{cidr}";
          tooltip-format-ethernet = "{ipaddr}/{cidr}";
          interval = 2;
        };
        memory = {
          format = " {percentage}%";
          tooltip-format = "{used:0.1f}/{total:0.1f} GiB";
          interval = 5;
        };
        "custom/power" = {
          format  = "";
          tooltip = false;
          menu = "on-click";
          menu-file = "~/.config/waybar/power_menu.xml";
          menu-actions = {
            shutdown = "systemctl poweroff";
            reboot = "systemctl reboot";
            logout = "hyprctl dispatch exit";
            lock = "hyprlock";
          };
        };
        "custom/logo" = {
          format = "  ";
          tooltip = false;
          on-click = "vicinae toggle";
        };
        clock = {
          tooltip-format = "{calendar}";
          format-alt = "  {:%a, %d %b %Y}";
          format = "⏰ {:%H:%M:%S}";
          interval = 1;
        };
        "hyprland/workspaces" = {
          on-click = "activate";
          format = "{icon}";
        };
        pulseaudio = {
          format = "{icon}  ({volume}%)";
          format-bluetooth = "󰂰";
          nospacing = 1;
          tooltip-format = "Volume : {volume}%";
          format-muted = "󰝟";
          format-icons = {
            headphone = "";
            default = [
              "󰖀"
              "󰕾"
              ""
            ];
          };
          on-click = "pavucontrol";
          on-click-right = "pamixer -t";
          scroll-step = 1;
        };
        "custom/gpu" = {
          format = " {}%";
          interval = 5;
          return-type = "";
          exec = "nvidia-smi --query-gpu=utilization.gpu --format=csv | tail -n 1 | sed 's/ %//'";
        };
        cava = {
          framerate = 60;
          autosens = 0;
          sensitivity = 69;
          bars = 21;
          lower_cutoff_freq = 50;
          higher_cutoff_freq = 10000;
          method = "pulse";
          source = "auto";
          stereo = false;
          reverse = false;
          bar_delimiter = 0;
          monstercat = false;
          waves = true;
          noise_reduction = 0.42;
          input_delay = 2;
          format-icons = [
            "▁"
            "▂"
            "▃"
            "▄"
            "▅"
            "▆"
            "▇"
            "█"
          ];
          actions = {
            on-click-right = "mode";
          };
        };
        battery = {
          format = "{capacity}% {icon}";
          format-icons = {
            charging = [
              "󰢜"
              "󰂆"
              "󰂇"
              "󰂈"
              "󰢝"
              "󰂉"
              "󰢞"
              "󰂊"
              "󰂋"
              "󰂅"
            ];
            default = [
              "󰁺"
              "󰁻"
              "󰁼"
              "󰁽"
              "󰁾"
              "󰁿"
              "󰂀"
              "󰂁"
              "󰂂"
              "󰁹"
            ];
          };
          format-full = "Charged ";
          interval = 5;
          states = {
            warning = 20;
            critical = 10;
          };
          tooltip = false;
        };
      };
      style = ''
        * {
          border: none;
          border-radius: 0;
          min-height: 0;
          font-family: "Fira Code";
          font-size: 13px;
        }

        window#waybar {
          background-color: rgba(0, 0, 0, 0);
          transition-property: background-color;
          transition-duration: 0.5s;
        }

        window#waybar.hidden {
          opacity: 0.5;
        }

        #workspaces {
          background-color: transparent;
        }

        #custom-spacer {
          color: rgba(180, 190, 254, 0.8);
        }

        #cava {
          color: rgba(203, 166, 247, 0.8);
          background-color: transparent;
        }

        #workspaces button {
          all: initial;
          min-width: 0;
          box-shadow: inset 0 -3px transparent;
          padding: 6px 18px;
          margin: 6px 3px;
          border-radius: 4px;
          background-color: rgba(49, 50, 68, 0.8);
          color: #cdd6f4;
        }

        #workspaces button.active {
          color: #1e1e2e;
          background-color: rgba(205, 214, 244, 0.8);
        }

        #workspaces button:hover {
          box-shadow: inherit;
          text-shadow: inherit;
          color: #1e1e2e;
          background-color: rgba(245, 224, 220, 0.8);
        }

        #workspaces button.urgent {
          background-color: rgba(243, 139, 168, 0.8);
        }

        #memory,
        #custom-power,
        #battery,
        #backlight,
        #pulseaudio,
        #network,
        #cpu,
        #custom-gpu,
        #clock
        {
          border-radius: 4px;
          margin: 6px 3px;
          padding: 6px 12px;
          color: #181825;
          background-color: rgba(250, 179, 135, 0.8);
        }
        
        #tray {
          border-radius: 4px;
          margin: 6px 3px;
          padding: 6px 12px;
          color: rgba(203, 166, 247, 0.8);
          background-color: transparent;
        }

        #custom-power {
          margin-right: 6px;
        }

        #custom-logo {
          padding-right: 7px;
          padding-left: 7px;
          margin-left: 5px;
          font-size: 15px;
          border-radius: 8px 0px 0px 8px;
          color: #1793d1;
        }

        #battery {
          background-color: #f38ba8;
        }

        #battery.warning,
        #battery.critical,
        #battery.urgent {
          background-color: #ff0000;
          color: #ffff00;
        }

        #battery.charging {
          background-color: #a6e3a1;
          color: #181825;
        }

        #backlight {
          background-color: #fab387;
        }

        #pulseaudio {
          background-color: rgba(249, 226, 175, 0.8);
        }

        #clock {
          font-family: "Fira Code";
          background-color: rgba(203, 166, 247, 0.8);
        }

        #custom-power {
          background-color: rgba(243, 139, 168, 0.8);
        }

        tooltip {
          border-radius: 8px;
          padding: 15px;
          background-color: #131822;
        }

        tooltip label {
          padding: 5px;
          background-color: #131822;
        }
      '';
    };
    xdg.configFile."waybar/power_menu.xml" = {
      text = ''
 <?xml version="1.0" encoding="UTF-8"?>
 <interface>
     <object class="GtkMenu" id="menu">
         <child>
             <object class="GtkMenuItem" id="lock">
                 <property name="label">🔒 Lock</property>
             </object>
         </child>
         <child>
             <object class="GtkMenuItem" id="logout">
                 <property name="label">🚪 Logout</property>
             </object>
         </child>
         <child>
             <object class="GtkSeparatorMenuItem" id="delimiter1" />
         </child>
         <child>
             <object class="GtkMenuItem" id="shutdown">
                 <property name="label">🛑 Shutdown</property>
             </object>
         </child>
         <child>
             <object class="GtkMenuItem" id="reboot">
                 <property name="label">🔁 Reboot</property>
             </object>
         </child>
     </object>
 </interface>
      '';
      executable = true;
    };
  };
}
