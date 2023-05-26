{ pkgs ? import <nixpkgs> {} }:
let np = pkgs.nodePackages; in
pkgs.mkShell {
  packages = [ pkgs.nodejs np.npm np.parcel np.purs-tidy ] ;
}
