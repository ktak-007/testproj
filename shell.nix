{ nixpkgs ? import <nixpkgs> {}
}:

let
  name = "Test Haskell environment";

  projectPackages = with nixpkgs; [
   ghc
   cabal2nix
   cabal-install
   haskellPackages.haskell-language-server
  ];

  funPackages = with nixpkgs; [
    figlet
    boxes
    lolcat
  ];

in nixpkgs.mkShell {
  buildInputs = projectPackages ++ funPackages;

  shellHook = ''
    echo
    echo "${name}" | figlet -t -f kban | lolcat -f
    echo
  '';
}
