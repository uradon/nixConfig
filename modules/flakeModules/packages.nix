{ inputs, ... }:

{
  perSystem = { pkgs, ... }: {

    packages.happ = import ../packages/happ.nix {
      inherit pkgs;
    };

  };
}
