{ self, inputs, ... }: {
  flake.nixosModules.niri = { pkgs, lib, ... }: {
    programs.niri = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
    };
    xdg.portal.config.niri = {
      "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ]; # or "kde"
    };
    services.greetd = {                                                      
      enable = true;                                                         
      settings = {                                                           
	default_session = {
	  command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd niri-session";
	  user = "greeter";                                                  
	};
      };                                                                     
    };

  };

  perSystem = { pkgs, lib, self', ... }: {
    packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
      inherit pkgs; 
      settings = {
        spawn-at-startup = [
          (lib.getExe self'.packages.myNoctalia)
	  "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=niri"
	  "systemctl --user start graphical-session.target"
        ];

        xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

        input = {
          mod-key = "Super";
          mod-key-nested = "Super";
          
          keyboard.xkb = {
            layout = "us,ru";
            # Sets Alt+Shift to toggle between your US and RU layouts natively
            options = "grp:alt_shift_toggle";
          };
        };

        #layout.gaps = 5;
	binds = {

	  "Mod+Slash".show-hotkey-overlay = [];

          "Mod+Return".spawn-sh = lib.getExe pkgs.kitty;
          "Mod+D".spawn-sh =  "${lib.getExe self'.packages.myNoctalia} ipc call launcher toggle";

	  "Print".screenshot = [];

          "Mod+Q".close-window = [];
          "Mod+Comma".consume-window-into-column = [];
          "Mod+Period".expel-window-from-column = [];

          "Mod+Left".focus-column-left = [];
          "Mod+Right".focus-column-right = [];
          "Mod+Down".focus-window-down = [];
          "Mod+Up".focus-window-up = [];
          
	  "Mod+1".focus-workspace-up = [];
          "Mod+2".focus-workspace-down = [];

          "Mod+Shift+1".move-window-to-workspace = 1;
          "Mod+Shift+2".move-window-to-workspace = 2;
          "Mod+Shift+3".move-window-to-workspace = 3;
          "Mod+Shift+4".move-window-to-workspace = 4;
          "Mod+Shift+5".move-window-to-workspace = 5;

	  #floating
	  "Mod+J".toggle-window-floating = [];
	  "Mod+Shift+J".switch-focus-between-floating-and-tiling = [];
	  "Mod+Shift+P".spawn-sh = "niri msg action toggle-window-floating && niri msg action set-window-height '-30%' && niri msg action set-column-width '-30%' && niri msg action move-floating-window -x 1500 -y 800";

	  #size
          "Mod+R".switch-preset-column-width = [];
          "Mod+F".maximize-column = [];
          "Mod+Shift+F".fullscreen-window = [];

          "Mod+Shift+E".quit = [];
        };
      };
    };
  };
}
