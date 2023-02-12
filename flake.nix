{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
  };

  outputs = { self, nixpkgs, ... }:
    let
      pkgs = import nixpkgs { system = "x86_64-linux"; }; in
    {
      defaultPackage.x86_64-linux =
        pkgs.stdenv.mkDerivation {
          name = "sgpt";
          propagatedBuildInputs = [
            (pkgs.python311.withPackages (pythonPackages: with pythonPackages; [
              typer
              requests
              rich
            ]))
          ];
          dontUnpack = true;
          installPhase = "install -Dm755 ${./sgpt.py} $out/bin/sgpt";
        };
    };
}
