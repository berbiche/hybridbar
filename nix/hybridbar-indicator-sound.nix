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
, libhandy
, libnotify
, pulseaudio
, libcanberra-gtk3
}:

stdenv.mkDerivation {
  pname = "hybridbar-indicator-sound";
  version = hybridbar.version;

  src = "${hybridbar.src}/indicators/sound";

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
    libhandy
    libnotify
    pulseaudio
    libcanberra-gtk3
  ];

  postPatch = ''
    chmod +x meson/post_install.py
    patchShebangs meson/post_install.py
  '';

  meta = with lib; {
    description = "Hybridbar sound indicator";
    homepage = "https://github.com/hcsubser/hybridbar";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
    maintainers = with maintainers; [ berbiche ];
  };
}
