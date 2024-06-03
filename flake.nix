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
          evmc = (pkgs.callPackage ./nix/evmc/evmc.nix { });
          cmake_modules = (pkgs.callPackage ./nix/cmake_modules/cmake_modules.nix { });
          # The "all" package will build all packages. Convenient for CI,
          # so that "nix build" will check that all packages are correct.
          # The packages that have no changes will not be rebuilt, and instead
          # fetched from the cache.
          all = pkgs.symlinkJoin {
            name = "all";
            paths = [ intx hashtree sszpp evmc cmake_modules ];
          };
          default = all;
        };

        overlays.default = final: prev: packages;
      }));
}
