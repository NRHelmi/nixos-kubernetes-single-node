let
  configs = builtins.fromJSON (builtins.readFile ./config.json);
  ip = (builtins.elemAt configs 0).ip;
in
{
  meta = {
    nixpkgs = import (import ./nixpkgs.nix) {};
    specialArgs = {};
  };

  kube-master = { name, nodes, ... }: {
    deployment.targetHost = ip;
    deployment.targetUser = "root";

    imports = [
        ./modules/base.nix
        ./modules/k8s.nix
    ];
  };
}
