{ nixpkgs ? import <nixpkgs> {}
, sources ? import ./nix/sources.nix
}:

let
  name = "Test Haskell Project";

  pkgs = import sources.nixpkgs {};

  haskell = pkgs.haskellPackages;
  haskellWithPackages = haskell.ghcWithPackages (hpkgs: with hpkgs; [
  ]);

  projectPackages = with haskellWithPackages; [
    # ghc
    # ghcid
    # cabal2nix
    # cabal-install
    # haskellPackages.haskell-language-server
  ];

  funPackages = with nixpkgs; [
    figlet
    boxes
    lolcat
    onefetch
  ];

in
  nixpkgs.mkShell {
    packages = projectPackages ++ [
      # haskellWithPackages
      haskell.ghcid
      haskell.cabal-install
      # haskell.cabal2nix
      # haskell.haskell-language-server
    ]
    ++ funPackages;

    inputsFrom = [(import ./default.nix {}).copyrights.env];

  shellHook = ''
    echo
    echo "${name}" | figlet -t -f banner3-D | lolcat -f
    onefetch
    echo -e "${name} development shell\n\nUsage:\tnix-build\n\tcat test/atf.txt | result/bin/coloring\n\tghcid --command 'cabal repl'" | boxes -d parchment | lolcat -f
    echo
  '';

  }
