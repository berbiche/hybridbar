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
, gettext
, json-glib
, python3
, gobject-introspection
, libhandy
, accountsservice
}:

stdenv.mkDerivation {
  pname = "hybridbar-indicator-session";
  version = hybridbar.version;

  src = "${hybridbar.src}/indicators/session";

  nativeBuildInputs = [
    gettext
    meson
    ninja
    pkg-config
    python3
    vala
    wrapGAppsHook
    gobject-introspection
  ];

  buildInputs = [
    hybridbar
    pantheon.elementary-gtk-theme
    pantheon.elementary-icon-theme
    pantheon.granite
    gtk3
    libhandy
    accountsservice
  ];

  postPatch = ''
    chmod +x data/post_install.py
    patchShebangs data/post_install.py
  '';

  meta = with lib; {
    description = "Hybridbar session indicator";
    homepage = "https://github.com/hcsubser/hybridbar";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
    maintainers = with maintainers; [ berbiche ];
  };
}
