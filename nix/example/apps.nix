{ inputs
, cell
}:
let
  inherit (inputs) nixpkgs std;
  l = nixpkgs.lib // builtins;
in
{
  default = with inputs.nixpkgs; rustPlatform.buildRustPackage {
    pname = "example";
    version = "0.1.0";
    src = std.incl (inputs.self) [
      (inputs.self + /Cargo.toml)
      (inputs.self + /Cargo.lock)
      (inputs.self + /src)
    ];
    cargoLock = {
      lockFile = inputs.self + "/Cargo.lock";
    };
    meta = {
      description = "An example Rust binary which greets the user";
    };
  };
}

