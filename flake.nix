{
  description = "Purescript Flake";

  inputs = {
    flake-compat.flake = false;
    flake-compat.url = github:edolstra/flake-compat;
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "nixpkgs/nixos-unstable";
    easy-purescript-nix = {
      url = "github:justinwoo/easy-purescript-nix";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, flake-utils, flake-compat, easy-purescript-nix }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        epkgs = import easy-purescript-nix { inherit pkgs; };
      in
      {
        devShell =
          pkgs.mkShell {
            buildInputs = [
              epkgs.purs-backend-es
              epkgs.purs-tidy
              epkgs.spago
              epkgs.zephyr
              # pkgs.nodejs-16_x
              pkgs.dhall
              pkgs.nixfmt
              pkgs.purescript
            ];
          };
      });
}

