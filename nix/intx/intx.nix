{ lib, stdenv, fetchFromGitHub, pkgs }:

stdenv.mkDerivation rec {
  name = "intx";
  version = "0.10.1";

  src = fetchFromGitHub {
    owner = "chfast";
    repo = "intx";
    rev = "v${version}";
    hash = "sha256-QgXttM4Y9z42ZHGyMTBZuQVe6S3olEc+qht3OyeaZtI=";
  };

  nativeBuildInputs = [ pkgs.cmake ];

  cmakeFlags = [ "-DINTX_TESTING=OFF" ];
}
