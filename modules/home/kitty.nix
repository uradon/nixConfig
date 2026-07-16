{ inputs, self, ...} :

{
  flake.homeModules.kitty = { config, lib, ...} : {
    options = {
      kitty.enable = 
	lib.mkEnableOption "enables kitty terminal";
    };

    config = lib.mkIf config.kitty.enable {
      programs.kitty = {
	enable = true;
	settings = {
	  input_delay = 0;
	  repaint_delay = 2;
	  sync_to_monitor = false;
	  wayland_enable_ime = false;
	  confirm_os_window_close = 0;
	  dynamic_background_opacity = true;
	  enable_audio_bell = false;
	  mouse_hide_wait = "-1.0";
	  window_padding_width = 10;
	  background_blur = 5;
	  symbol_map = "U+E0A0-U+E0FF,U+2600-U+26FF Symbols Nerd Font";
	};
      }; 
   };
  };
}
