{
  inputs.std.url = "github:divnix/std";
  inputs.nixpkgs.url = "nixpkgs";
  inputs.rust-overlay.url = "github:oxalica/rust-overlay";

  outputs = { std, ... } @ inputs:
    std.growOn
      {
        inherit inputs;
        cellsFrom = ./nix;
        cellBlocks = [
          (std.blockTypes.runnables "apps")
          (std.blockTypes.devshells "devshells")
          (std.blockTypes.functions "toolchain")
        ];
      }
      {
        packages = std.harvest inputs.self [ "example" "apps" ];
        devShells = std.harvest inputs.self [ "example" "devshells" ];
      };
}

