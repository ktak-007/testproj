{ sources ? import ./nix/sources.nix
}:
let pkgs = import sources.nixpkgs {};
in
{ copyrights = pkgs.haskellPackages.callCabal2nix "testproj" ./. {};
}
