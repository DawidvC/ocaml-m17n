type state

val keywords : (string, Parser.token) Hashtbl.t

val create : M17n_sedlexing.lexbuf -> state

val skip_sharp_bang : state -> unit
val token : state -> Parser.token

val token' : state -> Lexing.lexbuf -> Parser.token
