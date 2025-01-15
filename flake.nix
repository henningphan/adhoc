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
      devShells.${system}.default = let
      quit = pkgs.writeScriptBin "quit" ''
        sudo curl --unix-socket ch.sock -i -X PUT  http://localhost/api/v1/vmm.shutdown
        '';

      in
        pkgs.mkShell {
          buildInputs = with pkgs; [
            cloud-hypervisor
            jq
            virtiofsd
          qemu-utils
          quit
          ];
        };

  };
}
