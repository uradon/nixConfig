{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.services.happ;
  happ-package = pkgs.callPackage ./happ.nix {};
in
{
  options.services.happ = {
    enable = mkEnableOption "Happ VPN/Proxy desktop client and background TUN daemon";
  };

  config = mkIf cfg.enable {
    # 1. System packages and network utilities required for sing-box/Happ to function
    environment.systemPackages = [
      happ-package
      pkgs.net-tools
      pkgs.lsb-release
    ];

    # 2. Activation script to bypass hardcoded paths in /opt/happ
    system.activationScripts.setupHapp = stringAfter [ "stdio" ] ''
      mkdir -p /opt
      rm -rf /opt/happ
      cp -r ${happ-package}/happ /opt/happ
      chmod -R 777 /opt/happ
    '';

    # 3. Automatic firewall configuration for Happ TUN mode
    networking.firewall.checkReversePath = "loose";
    networking.firewall.trustedInterfaces = [ "tun0" ];

    # 4. A background daemon for managing TUN interfaces as root
    systemd.services.happd = {
      description = "Happ Process Control Daemon";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      
      path = with pkgs; [ iproute2 iptables procps net-tools ];
      
      serviceConfig = {
        Type = "simple";
        User = "root";
        Group = "root";
        ExecStart = "/opt/happ/bin/happd";
        Restart = "on-failure";
        RestartSec = "5s";
        NoNewPrivileges = false;
        TimeoutStopSec = "10s";
        KillMode = "mixed";
        KillSignal = "SIGTERM";
      };
    };
  };
}
