# see https://github.com/serokell/templates/blob/master/haskell-cabal2nix/flake.nix
{
  description = "My haskell application";

  inputs = { flake-utils.url = "github:numtide/flake-utils"; };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        haskellPackages = pkgs.haskellPackages;

        jailbreakUnbreak = pkg:
          pkgs.haskell.lib.doJailbreak (pkg.overrideAttrs (_: { meta = { }; }));

        packageName = throw "put your package name here!";
      in rec {
        packages.${packageName} = haskellPackages.callCabal2nix packageName self
          rec {
            # Dependency overrides go here (use to remove cabal version constraints)
            #
            # gi-gtk-declarative =
            #   jailbreakUnbreak haskellPackages.gi-gtk-declarative;
          };

        defaultPackage = self.packages.${system}.${packageName};

        devShell = haskellPackages.shellFor {
          packages = ps: [ packages.${packageName} ];
          buildInputs = with haskellPackages; [
            haskell-language-server
            hoogle
          ];
          withHoogle = false;
        };
      });
}
