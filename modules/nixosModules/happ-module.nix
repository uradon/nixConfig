{ self, inputs, ... }:

{
  flake.nixosModules.happModule = { config, lib, pkgs, ... }:

    let
      cfg = config.services.happ;
      happ-package = pkgs.callPackage ../../packages/happ.nix {};
    in
    {
      options.services.happ = {
        enable = lib.mkEnableOption "Happ VPN/Proxy desktop client and background TUN daemon";
      };

      config = lib.mkIf cfg.enable {

        environment.systemPackages = [
          happ-package
          pkgs.net-tools
          pkgs.lsb-release
        ];

        system.activationScripts.setupHapp = ''
          mkdir -p /opt
          rm -rf /opt/happ
          cp -r ${happ-package}/happ /opt/happ
          chmod -R 755 /opt/happ
        '';

        networking.firewall.checkReversePath = "loose";
        networking.firewall.trustedInterfaces = [ "tun0" ];

        systemd.services.happd = {
          description = "Happ Process Control Daemon";
          wantedBy = [ "multi-user.target" ];
          after = [ "network.target" ];

          path = with pkgs; [
            iproute2
            iptables
            procps
            net-tools
          ];

          serviceConfig = {
            Type = "simple";
            User = "root";
            Group = "root";

            ExecStart = "/opt/happ/bin/happd";

            Restart = "on-failure";
            RestartSec = 5;

            KillMode = "mixed";
            KillSignal = "SIGTERM";
            TimeoutStopSec = 10;
          };
        };
      };
    };
}
