{
  description = "hybridbar packaging";

  outputs = { self, nixpkgs }: let
    platforms = [ "x86_64-linux" ];
  in builtins.foldl' (acc: system: let
    pkgs = import nixpkgs { inherit system; };
  in acc // {
    packages.${system} = pkgs.callPackage ./nix { };

    devShell.${system} = pkgs.mkShell {
      name = "hybridbar-shell";

      buildInputs = with pkgs; [
        vala-language-server
        vala_0_54
        meson
        glib.dev
      ] ++ self.packages.${system}.hybridbar.buildInputs;
    };
  }) { } platforms;
}
