{
  description = "Make a flake for building msbreew.c";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      nixpkgs,
      flake-utils,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        packages = rec {
          msbreew = default;
          default = pkgs.stdenv.mkDerivation {
            name = "msbreew";
            src = ./.;
            buildInputs = [ pkgs.gcc ];
            buildPhase = "gcc -o msbreew msbreew.c";
            installPhase = ''
              mkdir -p $out/bin
              cp msbreew $out/bin/
            '';
          };
        };
      }
    );
}
