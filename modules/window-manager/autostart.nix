{ config, lib, pkgs, ... }:

let
  mkDesktopService = { name, description, command, restart ? "always", wantedBy ? [ "graphical-session.target" ] }:
    let
      serviceName = "app-${name}";
    in {
      systemd.user.services.${serviceName} = {
        Unit = {
          Description = description;
          After = [ "waybar.service" ];
          Wants = [ "waybar.service" ];
        };
        
        Service = {
          Type = "simple";
          ExecStart = "${command}";
          Restart = restart;
          RestartSec = "5s";
          Environment = "DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/%U/bus";
        };
        
        Install = {
          WantedBy = wantedBy;
        };
      };
    };
in
lib.mkMerge [
  (mkDesktopService {
    name = "cider";
    description = "Apple Music client";
    command = "${pkgs.cider-2}/bin/cider-2";
  })
  (mkDesktopService {
    name = "mullvad";
    description = "Start mullvad gui";
    command = "${pkgs.mullvad-vpn}/bin/mullvad-vpn";
  })
  (mkDesktopService {
    name = "thunderbird";
    description = "Email client";
    command = "${pkgs.thunderbird}/bin/thunderbird";
  })
  (mkDesktopService {
    name = "vesktop";
    description = "Vencord Desktop";
    command = "${pkgs.vesktop}/bin/vesktop";
  })
]
