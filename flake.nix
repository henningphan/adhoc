{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: let
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
    system = "x86_64-linux";
      in
      {

    packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;

    packages.x86_64-linux.default = self.packages.x86_64-linux.hello;
      devShells.${system}.default =
        pkgs.mkShell {
          buildInputs = with pkgs; [
            cloud-hypervisor
            virtiofsd
          ];
        };

  };
}
