{ lib
, stdenv
, fetchFromGitHub
, fetchpatch
, automake
, enableDebug ? false
}:

let
  inherit (lib) optional;
in

stdenv.mkDerivation rec {
  name = "hashtree";
  version = "0.2.0";

  src = fetchFromGitHub {
      owner = "prysmaticlabs";
      repo = "hashtree";
      rev = "v${version}";
      hash = "sha256-h+Jh1/Ne35rt5rBm/FADz27VAsTIXNmZfnvhk+rsCjw=";
    };

  patches = [
    ./hashtree-execstack-fix.diff
  ];

  outputs = [ "out" ];

  env.NIX_CFLAGS_COMPILE = lib.optionalString stdenv.cc.isClang "-no-integrated-as -std=c2x";

  doCheck = true;
  dontStrip = enableDebug;

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
