{
  description = "flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
  };

  outputs = { self, nixpkgs }@inputs:{
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        modules = [./configuration.nix];
      };
    };
 };
}
