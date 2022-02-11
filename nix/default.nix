{ lib, pkgs }:

lib.makeScope pkgs.newScope (self: with self; {
  hybridbar = callPackage ./hybridbar.nix { };
  hybridbar-indicators = lib.recurseIntoAttrs (callPackage ./indicators.nix { });
  hybridbar-with-indicators = callPackage ./wrapper.nix { };
})
