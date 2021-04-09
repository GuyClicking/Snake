{
  description = "A flake for building and running snake";

  inputs.nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;

  outputs = { self, nixpkgs }: {
    defaultPackage.x86_64-linux = 
      with import nixpkgs { system = "x86_64-linux"; };
      stdenv.mkDerivation {
        name = "snake";
        src = self;
        buildInputs = [pkgs.gcc pkgs.coreutils pkgs.ncurses];
        buildPhase = "gcc -lncurses -o snake snake.c";
        installPhase = "mkdir -p $out/bin; install -t $out/bin snake";
      };
    defaultApp.x86_64-linux = {
      type = "app";
      program = "${self.defaultPackage.x86_64-linux}/bin/snake";
    };
  };
}