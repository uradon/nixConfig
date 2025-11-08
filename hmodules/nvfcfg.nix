{ config, pkgs, inputs, lib, ... }: 

{
  imports = [inputs.nvf.homeManagerModules.default]; 

  options = {
    nvfcfg.enable = 
      lib.mkEnableOption "enables nvf config";
  }; 
  config = lib.mkIf config.nvfcfg.enable { 
    programs.nvf = {
	enable = true;
	settings = {
	  vim = {
	    options.shiftwidth = 2;
	    autocomplete.nvim-cmp.enable = true; 
	    autopairs.nvim-autopairs.enable = true;
         
	    languages = {
	      enableLSP = true;
	      enableTreesitter = true; 
	      texlab.enable = true;
	      nix.enable = true;
	      clang.enable = true;
	    };
	  };
	};
      };
  };
}

