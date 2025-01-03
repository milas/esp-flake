final: prev: rec {
  # LLVM
  llvm-xtensa = prev.callPackage ./pkgs/llvm-xtensa-bin.nix {};
  llvm-xtensa-lib = prev.callPackage ./pkgs/llvm-xtensa-lib.nix {};

  # Rust
  rust-xtensa = import ./pkgs/rust-xtensa-bin.nix {
    rust = prev.rust;
    callPackage = prev.callPackage;
    lib = prev.lib;
    stdenv = prev.stdenv;
    fetchurl = prev.fetchurl;
  };

  esp-idf-full = prev.callPackage ./pkgs/esp-idf {};

  esp-idf-xtensa = esp-idf-full.override {
    toolsToInclude = [
      "xtensa-esp-elf"
      "esp32ulp-elf"
      "openocd-esp32"
      "xtensa-esp-elf-gdb"
    ];
  };

  esp-idf-esp32 = esp-idf-xtensa;
  esp-idf-esp32s2 = esp-idf-xtensa;
  esp-idf-esp32s3 = esp-idf-xtensa;

  esp-idf-riscv = esp-idf-full.override {
    toolsToInclude = [
      "riscv32-esp-elf"
      "openocd-esp32"
      "riscv32-esp-elf-gdb"
    ];
  };

  esp-idf-esp32c3 = esp-idf-riscv;
  esp-idf-esp32c6 = esp-idf-riscv;
  esp-idf-esp32h2 = esp-idf-riscv;
}
