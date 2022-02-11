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
, libgee
, libhandy
, libsoup
, gnome-menus
}:

stdenv.mkDerivation {
  pname = "hybridbar-indicator-menu";
  version = hybridbar.version;

  src = "${hybridbar.src}/indicators/menu";

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
    json-glib
    libhandy
    libgee
    libsoup
    gnome-menus
  ];

  postPatch = ''
    chmod +x meson/post_install.py
    patchShebangs meson/post_install.py
  '';

  meta = with lib; {
    description = "Hybridbar menu indicator";
    homepage = "https://github.com/hcsubser/hybridbar";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
    maintainers = with maintainers; [ berbiche ];
  };
}
