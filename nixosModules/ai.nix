{ pkgs, lib, config, ... }: {
  
  
  options = { 
    ai.enable =
      lib.mkEnableOption "enables local llm service";
  };
  
  config = lib.mkIf config.ai.enable {
    nixpkgs.config.rocmSupport = true;     



    nixpkgs.overlays = [
      (self: super: {
	llama-cpp = (super.llama-cpp.overrideAttrs (finalAttrs: previousAttrs: {
	  cmakeFlags = (previousAttrs.cmakeFlags or []) ++ [ "-DGGML_HIP=ON" ];
	})).override { rocmSupport = true; };
      })
    ];

    environment.systemPackages = with pkgs; [
      llama-cpp
      rocmPackages.rocm-runtime  
      rocmPackages.rocminfo
      rocmPackages.clr
      wget                      
    ];
    
    systemd.services.llama-server = {
      description = "llama.cpp server with ROCm";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      path = [ pkgs.llama-cpp ]; 
      environment = {
	HSA_OVERRIDE_GFX_VERSION = "11.5.1";
	# GGML_HIP_UMA = "0";
      };
      serviceConfig = {
	ExecStart = ''
	  ${pkgs.llama-cpp}/bin/llama-server \
	    -hf huihui-ai/Huihui-Qwen3-VL-32B-Thinking-abliterated
	    --hf-file GGUF/ggml-model-q8_0.gguf
	    --mmproj-url https://huggingface.co/huihui-ai/Huihui-Qwen3-VL-32B-Thinking-abliterated/resolve/main/GGUF/mmproj-model-f16.gguf
	    --host 127.0.0.1 \
	    --port 8080 \
	    -ngl 35
	  '';
       Restart = "always";
       User = "nobody";
       DynamicUser = true;
      };
    };

  };
}
