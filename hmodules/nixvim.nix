{ config, pkgs, inputs, ... }:

{
  imports = [ inputs.nixvim.homeManagerModules.nixvim ];
  
  programs.nixvim = {
    enable = true;

    opts = {
      shiftwidth = 2;
      relativenumber = true;
    };

    plugins = {
      neo-tree.enable = true;
      vimtex = {
        enable   = true;
        settings.view_method = "zathura";
      };

      treesitter.enable = true;

      "lsp-format" = {
        enable = true;
        lspServersToEnable = "all";
      };

      cmp = {
        enable = true;
        autoEnableSources = true;
        settings.sources = [
          { name = "nvim_lsp"; }
          { name = "path"; }
          { name = "buffer"; }
        ];
      };

      lsp = {
        enable = true;
        servers = {
          clangd.enable = true;
          texlab.enable = true;
          nixd.enable   = true;
        };
      };
    };
  };

}

