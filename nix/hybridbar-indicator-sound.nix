{ stdenv
, lib
, wrapGAppsHook
, pkg-config
, meson
, ninja
, vala
, gtk3
, pantheon # elementary-gtk-theme elementary-icon-theme
, libxml2
, gettext
, python3
, hybridbar
, glib
, libgee
, libcanberra-gtk3
, libnotify
, pulseaudio
}:

stdenv.mkDerivation rec {
  pname = "hybridbar-indicator-sound";
  version = hybridbar.version;

  # src = "${hybridbar.src}/indicators/sound";
  src = builtins.path {
    path = ../indicators/sound;
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
    libxml2
  ];

  buildInputs = [
    gtk3
    hybridbar
    libcanberra-gtk3
    libgee
    libnotify
    pantheon.elementary-gtk-theme
    pantheon.elementary-icon-theme
    pulseaudio
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
