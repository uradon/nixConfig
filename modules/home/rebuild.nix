{ inputs, ... }:

{
  flake.homeModules.rebuild = { pkgs, ...}:{
      home.packages = [
	(pkgs.writeShellScriptBin "rebuild" ''
	  if [ -z "$1" ]; then
	    echo "Error: Missing Argument"
	    echo "Usage: rebuild <hostname>"
	    exit 1
	  fi
	  TARGET_HOST="$1"
	  TARGET_PATH="$NIX_CONF_DIR/"
	  echo "Rebuilding $TARGET_HOST for path $TARGET_PATH"
	  nixos-rebuild switch --flake $NIX_CONF_DIR/#$TARGET_HOST
	'')
      ];
  };
}
