{ inputs
, cell
}:
let
  inherit (inputs) nixpkgs std;
  l = nixpkgs.lib // builtins;
in
l.mapAttrs (_: std.lib.dev.mkShell) {
  default = { ... }: {
    name = "example devshell";
    imports = [ std.std.devshellProfiles.default ];
    packages = [
      cell.toolchain.rust.stable.latest.default
    ];
    nixago = [
      cell.configs.conform
      cell.configs.lefthook
      cell.configs.prettier
      cell.configs.treefmt
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

