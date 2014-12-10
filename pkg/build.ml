#!/usr/bin/env ocaml
#directory "pkg"
#use "topkg.ml"

let () =
  let oc = open_out "src_test/_tags" in
  output_string oc (if Env.native then "true: pp_native\n" else "true: pp_byte\n");
  output_string oc {|"ru": include|};
  close_out oc

let () =
  Pkg.describe "m17n" ~builder:`OCamlbuild [
    Pkg.lib "pkg/META";
    Pkg.bin ~auto:true "src/pp_m17n" ~dst:"ocamlm17n";
    Pkg.doc "README.md";
    Pkg.doc "LICENSE.txt";
    Pkg.doc "CHANGELOG.md"; ]
