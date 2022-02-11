{
  description = "hybridbar packaging";

  outputs = { self, nixpkgs }: let
    platforms = [ "x86_64-linux" ];
  in builtins.foldl' (acc: system: acc // {
    packages.${system} = import ./default.nix { pkgs = import nixpkgs { inherit system; }; };
  }) { } platforms;
}
