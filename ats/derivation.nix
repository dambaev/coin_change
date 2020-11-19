{ stdenv, pkgs, fetchzip, fetchpatch, fetchgit, fetchurl }:
stdenv.mkDerivation {
  name = "coin_change";

  src = ./. ;
  buildInputs = with pkgs;
  [ ats2
    which
  ];
  postBuild = ''
    mkdir -p $out
    cp src/coin_change $out
  '';
  dontInstall = true;

}
