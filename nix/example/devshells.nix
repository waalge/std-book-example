{ inputs
, cell
}:
let
  inherit (inputs) nixpkgs std;
  l = nixpkgs.lib // builtins;
in
l.mapAttrs (_: std.std.lib.mkShell) {
  default = { ... }: {
    name = "example devshell";
    imports = [ std.std.devshellProfiles.default ];
    packages = [
      cell.toolchain.rust.stable.latest.default
    ];
    commands = [
      {
        name = "tests";
        command = "cargo test";
        help = "run the unit tests";
        category = "Testing";
      }
    ];
  };
}

