{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    llm-agents.url = "github:numtide/llm-agents.nix";
    nix-ros-overlay.url = "github:lopsided98/nix-ros-overlay/master";
  };

  outputs = { nixpkgs, home-manager, ... }@inputs: {
    devShells.x86_64-linux.ros2-humble =
      inputs.nix-ros-overlay.devShells.x86_64-linux.example-ros2-desktop-humble;

    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        ./hosts/v3

        home-manager.nixosModules.home-manager

        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "before-home-manager";
          home-manager.users.nop = import ./home/nop;
          home-manager.extraSpecialArgs = { inherit inputs; };
        }
      ];
    };
  };
}
