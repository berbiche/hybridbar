{ lib
, stdenv
, wrapGAppsHook
, glib
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

  buildInputs = [ hybridbar ] ++ plugins ++ map (x: x.buildInputs) plugins;

  dontUnpack = true;
  dontConfigure = true;
  dontBuild = true;

  preferLocalBuild = true;
  allowSubstitutes = false;

  installPhase = ''
    mkdir -p "$out"/share/glib-2.0/schemas
    for i in $(cat $pathsPath); do
      ${xorg.lndir}/bin/lndir -silent $i $out
    done

    # Catch schemas errors
    for i in "$out"/share/gsettings-schemas/*/glib-2.0/schemas/*.xml; do
      cp "$i" "$out"/share/glib-2.0/schemas/
    done
    ${glib.dev}/bin/glib-compile-schemas "$out"/share/glib-2.0/schemas
  '';

  preFixup = ''
    gappsWrapperArgs+=(
      --set HYBRIDBAR_INDICATORS_PATH "$out/lib/hybridbar"
      --prefix XDG_DATA_DIRS ":" "$out/etc/xdg"
    )
  '';

  inherit (hybridbar) meta;
}
