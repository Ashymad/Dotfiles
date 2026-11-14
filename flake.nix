{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }: let
    systems = [ "x86_64-linux" "aarch64-linux" ];
    forAllSystems = f: nixpkgs.lib.genAttrs systems (name: f name);
    sourcesA = nixpkgs.lib.sources.sourceByGlobs ./. [ "*/.*/**" ];
    sourcesList = nixpkgs.lib.fileset.toList (nixpkgs.lib.fileset.fromSource sourcesA);
    sourcesListTxt = map (val: let
      p = (builtins.elemAt (nixpkgs.lib.path.subpath.components (nixpkgs.lib.path.splitRoot val).subpath) 3);
      in "${p}"
    ) sourcesList;
    forAllFiles = f: nixpkgs.lib.genAttrs sourcesListTxt (name: f name);
  in {
    packages = forAllSystems (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in forAllFiles (
      name: pkgs.stdenv.mkDerivation {
        name = name;
        src = nixpkgs.lib.path.append ./. name;
        installPhase = ''cp -vr . $out'';
      }
    ));
  };
}
