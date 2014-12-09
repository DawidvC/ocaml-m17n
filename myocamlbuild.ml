open Ocamlbuild_plugin

let () = dispatch (
  function
  | After_rules ->
    flag ["ocaml"; "compile"; "pp_byte"; "m17n"] &
      S[A"-pp"; A"src/pp_m17n.byte"];
    flag ["ocaml"; "compile"; "pp_native"; "m17n"] &
      S[A"-pp"; A"src/pp_m17n.native"];
    flag ["ocaml"; "ocamldep"; "pp_byte"; "m17n"] &
      S[A"-pp"; A"src/pp_m17n.byte"];
    flag ["ocaml"; "ocamldep"; "pp_native"; "m17n"] &
      S[A"-pp"; A"src/pp_m17n.native"];

  | _ -> ())
