# 3-rd party libraries packaged for use in Nix projects

To use this flake, add it to your flake inputs:

```nix
{
  description = "My flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    nix-3rdparty.url = "github:NilFoundation/nix-3rdparty";
    ...
  };

  outputs = { self, nixpkgs, flake-utils, nix-3rdparty }:
    (flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs {
        inherit system;
        overlays = [ nix-3rdparty.overlays.${system}.default ];
      };
      ...
}

```
