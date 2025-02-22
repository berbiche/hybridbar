{ stdenv
, lib
, wrapGAppsHook
, pkg-config
, meson
, ninja
, vala
, gtk3
, hybridbar
, pantheon # granite
, gettext
, json-glib
, python3
, libindicator-gtk3
, indicator-application-gtk3
}:

stdenv.mkDerivation rec {
  pname = "hybridbar-indicator-system-tray";
  version = hybridbar.version;

  # src = "${hybridbar.src}/indicators/system-tray";
  src = builtins.path {
    path = ../indicators/system-tray;
    name = pname;
  };

  nativeBuildInputs = [
    gettext
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
    libindicator-gtk3
    indicator-application-gtk3
  ];

  mesonFlags = [ "-Dayatana-indicator-dir=${indicator-application-gtk3}/lib/indicators3/7/" ];

  meta = with lib; {
    description = "Hybridbar system-tray indicator";
    homepage = "https://github.com/hcsubser/hybridbar";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
    maintainers = with maintainers; [ berbiche ];
  };
}
