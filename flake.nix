{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        packages.default = pkgs.stdenv.mkDerivation (finalAttrs: {
          pname = "lvgl";
          version = "8.3.11";
          src = pkgs.fetchurl {
            url = "https://github.com/lvgl/lvgl/archive/refs/tags/v${finalAttrs.version}.tar.gz";
            hash = "sha256-g7cyWkt4y7GaOfOsdTRsgIaSbX+uq1/y2CXCDaC720Y=";
          };
          installPhase = ''
            mkdir -p $out/include
            cp lvgl.h $out/include
            cp -R src $out/include
          '';
        });
        formatter = pkgs.nixpkgs-fmt;
      }
    );
}
