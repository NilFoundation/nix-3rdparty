{ pkgs, stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  name = "evmc";
  version = "11.0.1";

  src = fetchFromGitHub {
    owner = "ethereum";
    repo = "evmc";
    rev = "v${version}";
    hash = "sha256-BSnKW35VvU/5VKVB7A5TjNnj0zkR4n4Dg4YsuoAJJuU=";
  };

  nativeBuildInputs = [ pkgs.cmake ];

  cmakeFlags = [
    "-DEVMC_TOOLS=FALSE"
  ];

  doCheck = true;
  dontStrip = true;
}
