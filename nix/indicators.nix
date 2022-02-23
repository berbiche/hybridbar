{ lib, callPackage }:

{
  hybridbar-indicator-bluetooth = callPackage ./hybridbar-indicator-bluetooth.nix {  };
  hybridbar-indicator-calendar = callPackage ./hybridbar-indicator-calendar.nix { };
  hybridbar-indicator-menu = callPackage ./hybridbar-indicator-menu.nix { };
  hybridbar-indicator-network = callPackage ./hybridbar-indicator-network.nix { };
  hybridbar-indicator-session = callPackage ./hybridbar-indicator-session.nix { };
  hybridbar-indicator-sound = callPackage ./hybridbar-indicator-sound.nix { };
  hybridbar-indicator-system-tray = callPackage ./hybridbar-indicator-system-tray.nix { };
}
