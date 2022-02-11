{ lib
, wrapGAppsHook
, glib
, stdenv
, xorg # lndir
, hybridbar
, hybridbar-indicators
}:

let
  plugins = lib.attrValues (lib.filterAttrs (n: _: lib.hasPrefix "hybridbar" n) hybridbar-indicators);
in
stdenv.mkDerivation rec {
  pname = "${hybridbar.pname}-with-indicators";
  version = hybridbar.version;

  src = null;

  paths = [ hybridbar ] ++ plugins;

  passAsFile = [ "paths" ];

  nativeBuildInputs = [
    glib
    wrapGAppsHook
  ];

  buildInputs = [ hybridbar ] ++ plugins;

  dontUnpack = true;
  dontConfigure = true;
  dontBuild = true;

  preferLocalBuild = true;
  allowSubstitutes = false;

  installPhase = ''
    mkdir -p $out
    for i in $(cat $pathsPath); do
      ${xorg.lndir}/bin/lndir -silent $i $out
    done
  '';

  preFixup = ''
    gappsWrapperArgs+=(
      --set HYBRIDBAR_INDICATORS_PATH "$out/lib/hybridbar"
    )
  '';

  inherit (hybridbar) meta;
}
