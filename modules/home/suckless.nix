{ inputs, self, ... }:

{
  flake.homeModules.suckless = { config, lib, pkgs,... }:{
    options.suckless = {
      enable = lib.mkEnableOption "enable suckless software config";
    };

    config = lib.mkIf config.suckless.enable {
      home.packages = with pkgs; [
	(pkgs.st.overrideAttrs (_: {
	  src = ../config/st;
	  patches = [ ../config/st/patches/st-universcroll-0.8.4.diff ];
	}))
	(pkgs.dmenu.overrideAttrs (_: {
	  src = ../config/dmenu;
	  patches = [ ];
	}))
	slock
      ];
    };
  };

}
