# esp-flake
ESP32(-C3, -S2, -S3, -C6, -H2) development environments for Nix.

Derivations for some packages live here:
 * [ESP-IDF & tools](https://github.com/espressif/esp-idf) - official Espressif SDK and Xtensa/RISC-V GCC compiler toolchains
 * [Xtensa Rust](https://github.com/esp-rs/rust-build) - fork of Rust with Xtensa target support
 * [Xtensa LLVM & libclang](https://github.com/espressif/llvm-project) - fork of LLVM with Xtensa support

Released into the public domain via CC0 (see `COPYING`).

## Versions

| Component | Version         | Release Date |
|-----------|-----------------|--------------|
| ESP-IDF   | v5.3.2          | Dec 2024     |
| Rust      | v1.83.0.1       | Dec 2024     |
| LLVM      | 18.1.2_20240912 | Sep 2024     |

## Rust
### `esp-idf-sys`
When building, the `esp-idf-sys` crate will automatically use the SDK provided by the `esp-idf-full` package via the `IDF_PATH` environment variable it sets.

#### Git
It's necessary to mark the ESP-IDF SDK directory as a "safe directory" in Git.

For example, with Home Manager:
```nix
{
  programs.git = {
    extraConfig = {
      safe.directory = "*";
    };
  };
}
```

I'm not sure of a better way than this, but it's worth noting that setting `safe.directory = "*"` does not have a _security_ impact.
By default, Git refuses to do anything if the repo path is owned by a different user, which is the case for anything in `/nix/store`.
Since the store is read-only, there's no risk of making changes to it anyway.

## Getting started
### `nix develop`

On Flake-enabled Nix:
```shell
nix develop github:milas/esp-flake#default
```

NOTE: Only `x86_64-linux` works - the hashes are hardcoded for that platform everywhere.

## Acknowledgments
- `pkgs/rust` package based on [rust-overlay](https://github.com/oxalica/rust-overlay)
- All the other forks of this Flake, especially the original [mirrexagon/nixpkgs-esp-dev](https://github.com/mirrexagon/nixpkgs-esp-dev)
