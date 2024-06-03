{ lib
, stdenv
, fetchFromGitHub
, fetchpatch
, cmake
, intx
, hashtree
, enableDebug ? false
}:

let
  inherit (lib) optional;
in

stdenv.mkDerivation rec {
  name = "sszpp";

  src = fetchFromGitHub {
      owner = "OffchainLabs";
      repo = "sszpp";
      rev = "ec97d8976d7f0a78eccbf59cab59eae4cf508ca9";
      hash = "sha256-310yiR02zAQ9v6TIdOYDuS7lVQJRhAeIEzaeVEGnMDA=";
    };

  outputs = [ "out" ];

  doCheck = true;
  env.NIX_CFLAGS_COMPILE = "-Wno-error=format-security -Wno-defaulted-function-deleted -Wno-unneeded-internal-declaration -Wno-logical-op-parentheses";

  cmakeFlags = [
    "-DCMAKE_CXX_STANDARD=23"
  ];

  cmakeBuildType = if enableDebug then "Debug" else "Release";

  patches = [
    ./sszpp-merkleize-remove.patch
  ];

  nativeBuildInputs = [
    cmake
  ];

  propagatedBuildInputs = [
    (intx.override { inherit enableDebug; })
    (hashtree.override { inherit enableDebug; })
  ];

  meta = with lib; {
    platforms = platforms.unix;
  };
}
