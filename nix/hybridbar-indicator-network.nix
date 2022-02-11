{ stdenv
, lib
, wrapGAppsHook
, pkg-config
, meson
, ninja
, vala
, gtk3
, hybridbar
, pantheon # gala granite
, gobject-introspection
, gettext
, json-glib
, python3
, libnma
, networkmanager
}:

stdenv.mkDerivation {
  pname = "hybridbar-indicator-network";
  version = hybridbar.version;

  src = "${hybridbar.src}/indicators/network";

  nativeBuildInputs = [
    gettext
    meson
    ninja
    pkg-config
    python3
    vala
    gobject-introspection
    wrapGAppsHook
  ];

  buildInputs = [
    hybridbar
    pantheon.elementary-gtk-theme
    pantheon.elementary-icon-theme
    pantheon.granite
    gtk3
    libnma
    networkmanager
  ];

  postPatch = ''
    chmod +x data/post_install.py
    patchShebangs data/post_install.py
  '';

  meta = with lib; {
    description = "Hybridbar network indicator";
    homepage = "https://github.com/hcsubser/hybridbar";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
    maintainers = with maintainers; [ berbiche ];
  };
}
