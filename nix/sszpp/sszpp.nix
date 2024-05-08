{ lib
, stdenv
, fetchFromGitHub
, fetchpatch
, cmake
, intx
, hashtree
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
  dontStrip = true;
  env.NIX_CFLAGS_COMPILE = "-Wno-error=format-security -Wno-defaulted-function-deleted -Wno-unneeded-internal-declaration -Wno-logical-op-parentheses";

  cmakeFlags = [
    "-DCMAKE_CXX_STANDARD=23"
  ];

  patches = [
    ./sszpp-merkleize-remove.patch
  ];

  nativeBuildInputs = [
    cmake
  ];

  propagatedBuildInputs = [
    intx
    hashtree
  ];

  meta = with lib; {
    platforms = platforms.unix;
  };
}
