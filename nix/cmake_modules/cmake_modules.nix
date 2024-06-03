{ stdenv, fetchFromGitHub, cmake }:

stdenv.mkDerivation {
  name = "cmake_modules";

  src = fetchFromGitHub {
    owner = "BoostCMake";
    repo = "cmake_modules";
    rev = "57639741ecf018835deb97a04db2200241d7fbd3";
    hash = "sha256-/Fu+Co1W/0/c7GhLLv1Ozyw7LyezYGZtj3NODfS339o=";
  };

  nativeBuildInputs = [ cmake ];
}
