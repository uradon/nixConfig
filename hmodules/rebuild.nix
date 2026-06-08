{ config, pkgs, lib, ... }:

let
  cfg = config.programs.rebuild-switch;
in
{
  options.programs.rebuild-switch.enable = lib.mkEnableOption "rebuild handle";

  config = lib.mkIf cfg.enable {
    home.packages = [
      (pkgs.writeShellScriptBin "rebuild" ''
 	nixos-rebuild switch --flake /home/beef/Config/nixConfig/#beef
      '')
    ];
  };
}
