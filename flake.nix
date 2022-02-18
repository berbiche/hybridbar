{
  description = "hybridbar packaging";

  outputs = { self, nixpkgs }: let
    platforms = [ "x86_64-linux" ];
  in builtins.foldl' (acc: system: acc // {
    packages.${system} = (import nixpkgs { inherit system; }).callPackage ./nix { };
  }) { } platforms;
}
