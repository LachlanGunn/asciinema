{
  lib,
  stdenv,
  rust,
  makeRustPlatform,
  version,
  libiconv,
  python3,
}:
(makeRustPlatform {
  cargo = rust;
  rustc = rust;
}).buildRustPackage
  {
    pname = "asciinema";
    inherit version;

    src = builtins.path {
      path = ./.;
      name = "asciinema";
    };

    dontUseCargoParallelTests = true;
    cargoLock.lockFile = ./Cargo.lock;
    cargoLock.outputHashes = {
      "avt-0.20.0" = "sha256-t4q/Mq7x2T3PwxmhVy/BUhDGVK5rBhYS3jdwEfRmHK8=";
    };
    nativeBuildInputs = [ rust ];

    buildInputs = lib.optionals stdenv.hostPlatform.isDarwin [
      libiconv
    ];

    nativeCheckInputs = [ python3 ];
  }
