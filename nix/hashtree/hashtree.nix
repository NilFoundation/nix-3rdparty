{ lib
, stdenv
, fetchFromGitHub
, fetchpatch
, automake
}:

let
  inherit (lib) optional;
in

stdenv.mkDerivation rec {
  name = "hashtree";
  version = "0.1.0";

  src = fetchFromGitHub {
      owner = "prysmaticlabs";
      repo = "hashtree";
      rev = "v${version}";
      hash = "sha256-DHoFX8mbn4QKGj5Ch6R87swsoqXUXDweGL2KYjRVZEg=";
    };

  patches = [
    ./hashtree-execstack-fix.diff
  ];

  outputs = [ "out" ];

  env.NIX_CFLAGS_COMPILE = lib.optionalString stdenv.cc.isClang "-no-integrated-as -std=c2x";

  doCheck = true;
  dontStrip = true;

  nativeBuildInputs = [
    automake
  ];

  makeFlags = [ "DESTDIR=$(out)" "PREFIX=" ];

  propagatedBuildInputs = [
  ];

  meta = with lib; {
    platforms = platforms.unix;
  };
}
