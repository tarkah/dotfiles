{
  rust-bin,
  system,
  naersk,
  src,
}: let
  toolchain = rust-bin.stable.latest.minimal.override {
    targets = ["wasm32-wasi"];
  };
  naersk-lib = naersk.lib.${system}.override {
    cargo = toolchain;
    rustc = toolchain;
  };
in
  naersk-lib.buildPackage {
    inherit src;
    doCheck = false;
    CARGO_BUILD_TARGET = "wasm32-wasi";
  }
