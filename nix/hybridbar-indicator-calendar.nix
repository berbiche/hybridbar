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

, evolution-data-server
, libical
, libhandy
}:

stdenv.mkDerivation {
  pname = "hybridbar-indicator-calendar";
  version = hybridbar.version;

  src = "${hybridbar.src}/indicators/calendar";

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
    evolution-data-server
    libhandy
    libical
  ];

  postPatch = ''
    chmod +x meson/post_install.py
    patchShebangs meson/post_install.py
  '';

  meta = with lib; {
    description = "Hybridbar calendar indicator";
    homepage = "https://github.com/hcsubser/hybridbar";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
    maintainers = with maintainers; [ berbiche ];
  };
}
