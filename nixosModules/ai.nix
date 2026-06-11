{ pkgs, lib, config, ... }: {
  
  
  options = { 
    ai.enable =
      lib.mkEnableOption "enables local llm service";
  };
  
  config = lib.mkIf config.ai.enable {
    nixpkgs.config.rocmSupport = true;     
    users.users.beef = {
      extraGroups = [ "render" "video" ];
    };
    boot.kernelParams = [ "amdgpu.xnack=1" ];
    #services.ollama = {
    #  enable = true;
    #  package = pkgs.ollama-rocm;
    #};



    nixpkgs.overlays = [
  (self: super: {
    llama-cpp-rocm = super.llama-cpp-rocm.overrideAttrs (oldAttrs: {
     
    
      cmakeFlags = (oldAttrs.nativeBuildInputs or []) ++ [
        "-DGGML_HIP=ON"
        "-DGGML_HIP_UVM=ON"
        "-DAMDGPU_TARGETS=gfx1200"
        "-DGGML_HIP_ROCWMMA_FATTN=ON"
        #"-DCMAKE_BUILD_TYPE=Release"

	#"-DCMAKE_CXX_FLAGS=-HSA_XNACK=1"
      ];
      preConfigure = (oldAttrs.preConfigure or "") + ''
        export HSA_XNACK=1
	export HIPCC_VERBOSE=1
	export CXXFLAGS="$CXXFLAGS -DHSA_XNACK=1"
	export HIPCC_FLAGS="$HIPCC_FLAGS --amdgpu-target=gfx1200 --offload-arch=gfx1200 -fgpu-rdc"

	export CMAKE_INCLUDE_PATH="${super.rocmPackages.rocwmma}/include:$CMAKE_INCLUDE_PATH"
        export CPLUS_INCLUDE_PATH="${super.rocmPackages.rocwmma}/include:$CPLUS_INCLUDE_PATH"
        export CMAKE_PREFIX_PATH="${super.rocmPackages.rocwmma}:$CMAKE_PREFIX_PATH"
      
      '';
    });
  })
];
    environment.systemPackages = with pkgs; [
      rocmPackages.rocwmma
      llama-cpp-rocm
      rocmPackages.rocm-runtime  
      rocmPackages.rocminfo
      rocmPackages.clr
      wget                      
    ];
    
    systemd.services.llama-server = {
      description = "llama.cpp server with ROCm";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      path = [ pkgs.llama-cpp-rocm ]; 
      environment = {
	HIP_VISIBLE_DEVICES="0";
	#GGML_HIP_UVM = "1";

	LLAMA_CPP_VERBOSE = "1";
	#HSA_OVERRIDE_GFX_VERSION = "12.0.1";

	#works but offloads all the cache to sytem RAM
	#GGML_CUDA_ENABLE_UNIFIED_MEMORY="ON";
      };
      serviceConfig = {
	ExecStart = ''${pkgs.llama-cpp-rocm}/bin/llama-server \
	  --hf-repo unsloth/gemma-4-26B-A4B-it-GGUF \
	  --host 127.0.0.1 \
	  --port 8001 \
	  --temp 1.0 \
	  --top-p 0.95 \
	  --top-k 64 \
	  --cache-type-k q4_0 \
	  --cache-type-v q4_0 \
	  --no-mmap \
	'';
	Type = "simple";
	User = "beef";
	Group = "users";
	DynamicUser = false;

	
      };
    };

  };
}
