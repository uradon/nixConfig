{ config, lib, ... }:

{
  options.starship = {
    enable = lib.mkEnableOption "enable starship prompt config";
    style = lib.mkOption {
      type = lib.types.enum [ "regular" "fancy" ];
      default = "regular";
    };
  };

  config = lib.mkIf config.starship.enable {
    programs.starship = {
      enable = true;
      settings =
        lib.mkMerge [
          (lib.mkIf (config.starship.style == "fancy") {
            format = "[$os]($style)$directory[$nix_shell]($style)$character";
            character.format = "> ";
            os = {
              disabled = false;
              style = "bold blue";
              symbols.NixOS = " ";
            };
            directory.read_only = "";
            custom.nix_shell = {
              detect = ''[ -n "$IN_NIX_SHELL" ]'';
              style = "bold cyan";
              format = "(fg:#89c0d0) ";
            };
          })
          (lib.mkIf (config.starship.style == "regular") {
	    format = "[[$username]($style_user)@[$hostname]($style_host)]($style_host) [$directory]($style_dir) $character";

	    style_user = "blue";
	    style_host = "bold blue";
	    style_dir  = "bold green";

	    character = {
	      format = "> ";
	      style  = "bold cyan";
	    };
	  })
        ];
    };
  };
}
