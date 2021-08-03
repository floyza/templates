{
  description = "My personal flake templates";

  outputs = { self }: {
    templates = {
      haskell = {
        path = ./haskell;
        description = "A haskell project using cabal2nix";
      };
      shell = {
        path = ./shell;
        description = "A basic devShell skeleton";
      };
      stack = {
        path = ./stack;
        description = "A haskell project using stack";
      };
    };
  };
}
