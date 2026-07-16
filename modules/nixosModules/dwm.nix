{ inputs, self, ... }:

{
  flake.nixosModules.dwm = {config, lib, pkgs, ... }: { 
    options.dwm = {
      enable = lib.mkEnableOption "enable dwm";
    };

    config = lib.mkIf config.dwm.enable {
      services.xserver.windowManager.dwm = {
	enable = true;
	package = pkgs.dwm.overrideAttrs {
	  src = ../config/dwm;
	};
	
	

      }; 
    };
  };
}
