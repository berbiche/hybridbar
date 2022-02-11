{ lib, callPackage }:

{
  hybridbar-indicator-calendar = callPackage ./hybridbar-indicator-calendar.nix { };
  hybridbar-indicator-menu = callPackage ./hybridbar-indicator-menu.nix { };
  hybridbar-indicator-network = callPackage ./hybridbar-indicator-network.nix { };
  hybridbar-indicator-session = callPackage ./hybridbar-indicator-session.nix { };
  hybridbar-indicator-sound = callPackage ./hybridbar-indicator-sound.nix { };
  hybridbar-indicator-system-tray = callPackage ./hybridbar-indicator-system-tray.nix { };
}

/*
{ stdenv
, lib
, hybridbar
, pantheon # gala granite
, wrapGAppsHook
, pkg-config
, meson
, ninja
, vala
, gtk3
, libgee
, gettext
, mesa
, json-glib
, python3
, gtk-layer-shell

, evolution-data-server
, libical
, libhandy
, libxml2
, libsoup
, libgdata
, gnome-menus
, libnma
, networkmanager
, accountsservice
, libnotify
, pulseaudio
, libcanberra-gtk3
#, libayatana-indicator-gtk3
, libindicator
}:

stdenv.mkDerivation {
  pname = "${hybridbar.pname}-indicators";
  version = hybridbar.version;

  src = hybridbar.src;

  nativeBuildInputs = [
    gettext
    meson
    ninja
    pkg-config
    python3
    vala
    wrapGAppsHook
    gtk-layer-shell
  ];

  buildInputs = [
    hybridbar
    pantheon.elementary-gtk-theme
    pantheon.elementary-icon-theme
    pantheon.gala
    pantheon.granite
    gtk3
    json-glib
    mesa # for libEGL

    # For libecal
    evolution-data-server
    libhandy
    libical
    libgee
    libxml2
    libsoup
    libgdata

    gnome-menus
    libnma
    networkmanager
    accountsservice

    libnotify
    pulseaudio
    libcanberra-gtk3
    #libayatana-indicator-gtk3
    libindicator
  ];

  dontUnpack = true;
  # dontConfigure = true;
  dontBuild = true;
  # dontFixup = true;

  dontUseNinjaBuild = true;
  dontUseNinjaInstall = true;

  configurePhase = ''
    mesonFlags="\
        --libdir=''${!outputLib}/lib --libexecdir=''${!outputLib}/libexec \
        --bindir=''${!outputBin}/bin --sbindir=''${!outputBin}/sbin \
        --includedir=''${!outputInclude}/include \
        --mandir=''${!outputMan}/share/man --infodir=''${!outputInfo}/share/info \
        --localedir=''${!outputLib}/share/locale \
        -Dauto_features=''${mesonAutoFeatures:-enabled} \
        -Dwrap_mode=''${mesonWrapMode:-nodownload} \
        $mesonFlags"
  '';

  installPhase = ''
    # The system-tray does not work on Wayland, so no point in compiling
    for dir in "$src"/*; do
      scriptdir=
      [ -f "$dir"/meson/post_install.py ] && scriptdir=meson
      [ -f "$dir"/data/post_install.py ] && scriptdir=data
      if [ ! -z "$scriptdir" ]; then
        chmod +x "$dir"/"$scriptdir"/post_install.py
        patchShebangs "$dir"/"$scriptdir"/post_install.py
      fi
    done
    for dir in "$src"/indicators/{calendar,menu,network,session,sound}; do
      # [ ! -d "$dir" ] && continue
      cp --no-preserve=mode -r "$dir" "$(basename "$dir")"
      pushd "$(basename "$dir")"
      echo "Building indicator $(basename "$dir")"
      meson build --prefix="$prefix" $mesonFlags "''${mesonFlagsArray[@]}"
      ninja -C build $ninjaFlags "''${ninjaFlagsArray[@]}" install
      popd
    done


  '';

  meta = with lib; {
    description = "Indicators for hybridbar";
    homepage = "https://github.com/hcsubser/hybridbar";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
    maintainers = with maintainers; [ berbiche ];
  };
}
*/
