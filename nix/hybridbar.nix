{ stdenv
, lib
, fetchFromGitHub
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
}:

stdenv.mkDerivation rec {
  pname = "hybridbar";
  version = "1.0.0";

  # src = fetchFromGitHub {
  #   owner = "hcsubser";
  #   repo = pname;
  #   rev = version;
  #   sha256 = "sha256-IiIkqsw+OMu6aqx9Et+cP0vXY19s+SGsTfikWX5r/cY=";
  # };
  src = builtins.path {
    path = ../.;
    name = "hybridbar";
    filter = path: type: let
      ignoredFiles = [
        "nix"
        "result"
        "indicators"
      ];
    in ! (builtins.any (p: p == baseNameOf path) ignoredFiles);
  };

  nativeBuildInputs = [
    gettext
    meson
    ninja
    pkg-config
    python3
    vala
    gtk-layer-shell
    wrapGAppsHook
  ];

  buildInputs = [
    pantheon.elementary-gtk-theme
    pantheon.elementary-icon-theme
    pantheon.gala
    pantheon.granite
    gtk3
    json-glib
    libgee
    mesa # for libEGL
  ];

  postPatch = ''
    chmod +x data/post_install.py
    patchShebangs data/post_install.py
  '';

  preFixup = ''
    gappsWrapperArgs+=(
      # this theme is required
      --prefix XDG_DATA_DIRS : "${pantheon.elementary-gtk-theme}/share"
    )
  '';

  meta = with lib; {
    description = "The extensible top panel for Wayland forked from wingpanel";
    longDescription = ''
      Hybridbar is an empty container that accepts indicators as extensions,
      including the applications menu.
    '';
    homepage = "https://github.com/hcsubser/hybridbar";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
    maintainers = with maintainers; [ berbiche ];
    mainProgram = "hybridbar";
  };
}
