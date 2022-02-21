{ stdenv
, lib
, wrapGAppsHook
, pkg-config
, meson
, ninja
, vala
, gtk3
, gobject-introspection
, python3
, hybridbar
, pantheon
, gettext
, libgee
, libnotify
}:

stdenv.mkDerivation rec {
  pname = "hybridbar-indicator-bluetooth";
  version = hybridbar.version;

  # src = "${hybridbar.src}/indicators/bluetooth";
  src = builtins.path {
    path = ../indicators/bluetooth;
    name = pname;
  };

  nativeBuildInputs = [
    gettext
    gobject-introspection
    meson
    ninja
    pkg-config
    python3
    vala
    wrapGAppsHook
  ];

  buildInputs = [
    hybridbar
    pantheon.elementary-gtk-theme
    pantheon.elementary-icon-theme
    pantheon.granite
    gtk3
    libgee
    libnotify
  ];

  meta = with lib; {
    description = "Hybridbar bluetooth indicator";
    homepage = "https://github.com/hcsubser/hybridbar";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
    maintainers = with maintainers; [ berbiche ];
  };
}
