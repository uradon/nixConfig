{ inputs, ... }:

{
  flake.nixosModules.rebuild = { pkgs, ...}:{
      environment.systemPackages = [
        (pkgs.writeShellScriptBin "rebuild" ''
          if [ -z "$1" ]; then
            echo "Error: Missing Argument"
            echo "Usage: rebuild <hostname>"
            exit 1
          fi
          TARGET_HOST="$1"
          TARGET_PATH="$MY_REBUILD_DIRECTORY"
          
          if [ -z "$TARGET_PATH" ]; then
            echo "Error: \$MY_REBUILD_DIRECTORY is not set"
            exit 1
          fi

          echo "Rebuilding $TARGET_HOST for path $TARGET_PATH"
          nixos-rebuild switch --flake "$TARGET_PATH#$TARGET_HOST"
        '')
        (pkgs.writeShellScriptBin "rebuild-proxy" '' 
          if [ -z "$1" ]; then
            echo "Error: Missing Argument"
            echo "Usage: rebuild-proxy <hostname>"
            exit 1
          fi
          sudo env http_proxy=http://127.0.0.1:10809 https_proxy=http://127.0.0.1:10809 MY_REBUILD_DIRECTORY="$MY_REBUILD_DIRECTORY" rebuild "$1"
        '')
      ];
  };
}

