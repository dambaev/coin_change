{ stdenv, pkgs, fetchzip, fetchpatch, fetchgit, fetchurl }:
stdenv.mkDerivation {
  name = "coin_change";

  src = ./. ;
  buildInputs = with pkgs;
  [ rustc
    which
  ];
  postBuild = ''
    mkdir -p $out
    cp src/coin_change $out
  '';
  dontInstall = true;

}
