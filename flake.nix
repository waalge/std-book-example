{
  inputs.std.url = "github:divnix/std";
  inputs.nixpkgs.url = "nixpkgs";
  outputs = { std, ... } @ inputs:
    std.growOn
      {
        inherit inputs;
        cellsFrom = ./nix;
        cellBlocks = [
          (std.blockTypes.runnables "apps")
        ];
      }
      {
        packages = std.harvest inputs.self [ [ "example" "apps" ] ];
      };
}
