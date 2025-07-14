let
  pkgs = import pkgsPath { allowUnfree = true; };
  pkgsPath = import ./nixpkgs.nix;

  make-boot-image = pkgs.writeShellScriptBin "make-boot-image" ''
    nixos-generate -f qcow -c cloudinit -o image/nixos-cloudimg.qcow2 -I nixos-config=./image/image.nix -I nixpkgs=${pkgsPath}
  '';
in
pkgs.mkShell {
  buildInputs = with pkgs; [
    colmena
    terraform
    nixos-generators
    nixVersions.latest

    # commands
    make-boot-image
  ];
}
