{ pkgs ? import <nixpkgs> {}}:

pkgs.mkShell {
  nativeBuildInputs = [
    pkgs.nodejs-16_x
    pkgs.yarn
    pkgs.pandoc
  ];
  shellHook = ''
    export PATH="$PWD/node_modules/.bin:$PATH";
  '';
}
