{config, pkgs, inputs, lib, ...} :

{

  options = {
    starship.enable = 
      lib.mkEnableOption "enables starship config";
  };

  config = {
    programs.starship = {
      enable = true;
      settings = {
	format = "[$os]($style)$directory[$nix_shell]($style)$character";
	character = {
	  format = "> ";
	};

	os = {
	  disabled = false;
	  style = "bold blue";
	  symbols = {
	    NixOS = " "; 
	  };
	};
	directory.read_only = "";
	#directory.read_only = "󰌾";
	custom.nix_shell = {
	  detect = ''[ -n "$IN_NIX_SHELL" ]'';  # Checks if in nix-shell
	  style = "bold cyan";
	  format = "(fg:#89c0d0) ";  
	};
      };
    };

  };
}
