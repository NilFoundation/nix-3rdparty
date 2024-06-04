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

  # We use our fork of SSZ++ until required changes are going to be merged.
  # See: https://github.com/OffchainLabs/sszpp/pull/3
  src = fetchFromGitHub {
      owner = "NilFoundation";
      repo = "sszpp";
      rev = "bac94fb2888c5e0ca98c88a3490dbd2c5feb5ce5";
      hash = "sha256-/FAae1maWI6fPsyNtaiUK52VnW+mwh/FOnC4G0+uCHI=";
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
