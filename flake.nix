{
  description = "Common 3-rd party libraries to reuse in Nix projects";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    (flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system; };

      in rec {
        packages = rec {
          intx = (pkgs.callPackage ./nix/intx/intx.nix { });
          hashtree = (pkgs.callPackage ./nix/hashtree/hashtree.nix { });
          sszpp = (pkgs.callPackage ./nix/sszpp/sszpp.nix {
            hashtree = hashtree;
            intx = intx;
          });
        };

        overlays.default = final: prev: packages;
      }));
}
