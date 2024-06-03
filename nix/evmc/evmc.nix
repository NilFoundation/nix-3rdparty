{ pkgs, stdenv, fetchFromGitHub, enableDebug ? true }:

stdenv.mkDerivation rec {
  name = "evmc";

  src = fetchFromGitHub {
    owner = "ethereum";
    repo = "evmc";
    rev = "fc86231960348790bbee8254a809bf1f9d7c8517";
    hash = "sha256-yqEbtRA4GiQ/pjaH2+ZPfnthgt9gLPY4lWPTYbBWJhE=";
  };

  nativeBuildInputs = [ pkgs.cmake ];

  cmakeBuildType = if enableDebug then "Debug" else "Release";

  doCheck = true;
  dontStrip = enableDebug;
}
