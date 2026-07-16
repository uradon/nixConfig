{ self, inputs, ... }: {
  flake.nixosModules.niri = { pkgs, lib, ... }: {
    programs.niri = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
    };
    services.greetd = {                                                      
      enable = true;                                                         
      settings = {                                                           
	default_session = {
	  command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd niri";
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

          "Mod+Q".close-window = [];
          "Mod+Comma".consume-window-into-column = [];
          "Mod+Period".expel-window-from-column = [];

          # Column / Window Navigation
          "Mod+Left".focus-column-left = [];
          "Mod+Right".focus-column-right = [];
          "Mod+Down".focus-window-down = [];
          "Mod+Up".focus-window-up = [];
          
          # Workspace Switching (1 through 9)
          "Mod+1".focus-workspace = 1;
          "Mod+2".focus-workspace = 2;
          "Mod+3".focus-workspace = 3;
          "Mod+4".focus-workspace = 4;
          "Mod+5".focus-workspace = 5;
          "Mod+6".focus-workspace = 6;
          "Mod+7".focus-workspace = 7;
          "Mod+8".focus-workspace = 8;
          "Mod+9".focus-workspace = 9;

          # Move Active Window to Workspaces
          "Mod+Shift+1".move-window-to-workspace = 1;
          "Mod+Shift+2".move-window-to-workspace = 2;
          "Mod+Shift+3".move-window-to-workspace = 3;
          "Mod+Shift+4".move-window-to-workspace = 4;
          "Mod+Shift+5".move-window-to-workspace = 5;

          # Layout & Sizing Adjustments
          "Mod+R".switch-preset-column-width = [];
          "Mod+F".maximize-column = [];
          "Mod+Shift+F".fullscreen-window = [];

          # Quit / Log out of Niri
          "Mod+Shift+E".quit = [];
        };
      };
    };
  };
}
