{
  description = "ESP32 & Rust";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    {
      overlays.default = import ./overlay.nix;
    }
    // flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [self.overlays.default];
      };
    in {
      packages = {
        inherit
          (pkgs)
          esp-idf-full
          esp-idf-esp32
          esp-idf-esp32c3
          esp-idf-esp32s2
          esp-idf-esp32s3
          esp-idf-esp32c6
          esp-idf-esp32h2
          espflash
          ldproxy
          llvm-xtensa
          llvm-xtensa-lib
          rust-xtensa
          ;
      };

      devShells.default = import ./shell.nix {inherit pkgs;};
      formatter = pkgs.alejandra;
      checks = import ./tests/build-idf-examples.nix {inherit pkgs;};
    });
}
