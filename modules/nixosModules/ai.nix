{ pkgs, lib, config, inputs, ... }: 

let 
    #mcpServers = inputs.nix-mcp-servers.packages.${pkgs.system};
in {
    options.ai.enable = lib.mkEnableOption "enables local llm service";
  
    config = lib.mkIf config.ai.enable {
      nixpkgs.config.rocmSupport = false;
     
      environment.systemPackages = with pkgs; [
	rocmPackages.rocm-smi
	rocmPackages.rocminfo
	llama-cpp-rocm
      ];


      nixpkgs.overlays = [
      
	(self: super: {
	  llama-cpp-rocm = super.llama-cpp-rocm.overrideAttrs (oldAttrs: {
     
    
	    cmakeFlags = (oldAttrs.ocmakeFlag or []) ++ [
	      "-DGGML_HIP=ON"
	      "-DGGML_RPC=ON"
	      "-DAMDGPU_TARGETS=gfx1200"
	      "-DGGML_HIP_ROCWMMA_FATTN=ON"
	      "-DCMAKE_BUILD_TYPE=Release"

	    ];
	    preConfigure = (oldAttrs.preConfigure or "") + ''
	      export HIPCC_VERBOSE=1
	      export CMAKE_INCLUDE_PATH="${super.rocmPackages.rocwmma}/include:$CMAKE_INCLUDE_PATH"
	      export CPLUS_INCLUDE_PATH="${super.rocmPackages.rocwmma}/include:$CPLUS_INCLUDE_PATH"
	      export CMAKE_PREFIX_PATH="${super.rocmPackages.rocwmma}:$CMAKE_PREFIX_PATH"
      
	    '';
	  });
	})
      ];

      systemd.services.llama-server = {
	description = "llama.cpp server with rocm";
	after = [ "network.target"  ];
	wantedBy = [ "multi-user.target" ];
	path = [ pkgs.llama-cpp-rocm];
	environment = {
	  HIP_VISIBLE_DEVICES="0";
	  LLAMA_CPP_VERBOSE = "1";
	};

	#unsloth/gemma-4-26B-A4B-it-GGUF
	#unsloth/Qwen3.6-27B-MTP-GGUF:UD-Q4_K_XL 
	#--cache-type-k q4_0 \
        #--cache-type-v q4_0 \

	serviceConfig = {
	  ExecStart = ''${pkgs.llama-cpp-rocm}/bin/llama-server \
	  --hf-repo unsloth/Qwen3.6-27B-MTP-GGUF:UD-Q4_K_XL \
	  --host 127.0.0.1 \
	  --port 8001 \
	  --ctx-size 50000 \
	  --temp 0.6 \
	  --top-p 0.95 \
	  --top-k 64 \
	  --n-gpu-layers 40 \
	  --no-mmap \
	  -fa on
	'';  
	  Type = "simple";
	  User = "beef";
	  Group = "users";
	  Restart = "always";
	};
      };
     

    };
}
