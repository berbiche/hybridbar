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
, libayatana-indicator-gtk3
, libindicator
}:

stdenv.mkDerivation {
  pname = "hybridbar-indicator-system-tray";
  version = hybridbar.version;

  src = "${hybridbar.src}/indicators/system-tray";

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
    libayatana-indicator-gtk3
    libindicator
  ];

  meta = with lib; {
    description = "Hybridbar system-tray indicator";
    homepage = "https://github.com/hcsubser/hybridbar";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
    maintainers = with maintainers; [ berbiche ];
  };
}
