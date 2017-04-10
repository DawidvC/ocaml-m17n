type lexbuf

(** [encode ?normalize uchars] returns the UTF-8 encoded string
    corresponding to the character list [uchars], optionally
    normalizing it as [normalize]. *)
val encode : ?normalize:[< `NFC | `NFD] -> Uchar.t list -> string

(* The interface used by Sedlex *)
val start : lexbuf -> unit
val next : lexbuf -> int
val mark : lexbuf -> int -> unit
val backtrack : lexbuf -> int

(** [create ~filename gen] creates a lexing buffer from generator [gen]
    that returns chunks of the input.
    Positions filled with {!fill_lexbuf} will have [filename] as their
    [pos_fname] field.
    If [kind] equals [`Batch] (the default), positions filled with
    [fill_lexbuf] will refer to characters. If [`Toplevel], to bytes.
    Additionally, with [kind = `Toplevel], [gen] will never be called
    speculatively. *)
val create : ?kind:[`Batch|`Toplevel] -> ?filename:string ->
             (bytes * int * int) Gen.t -> lexbuf

(** [lexeme lexbuf] returns the list of codepoints comprising
    the current lexeme. *)
val lexeme : lexbuf -> Uchar.t list

(** [lexeme_char n lexbuf] ≡ [List.nth (lexeme lexbuf) n] *)
val lexeme_char : int -> lexbuf -> Uchar.t

(** [sub_lexeme (lft, rgt) lexbuf] returns the subset of the list
    of codepoints comprising the current lexeme. [lft] and [rgt]
    indicate the amount of characters to sk *)
val sub_lexeme : int * int -> lexbuf -> Uchar.t list

(** [utf8_lexeme ?normalize lexbuf] ≡ [encode ?normalize (lexeme lexbuf)] *)
val utf8_lexeme : ?normalize:[< `NFC | `NFD] -> lexbuf -> string

(** [utf8_sub_lexeme ?normalize range lexbuf] ≡
    [encode ?normalize (sub_lexeme range lexbuf)] *)
val utf8_sub_lexeme : ?normalize:[< `NFC | `NFD] -> int * int -> lexbuf -> string

(** [expand_token lexbuf f] memorizes the token start position
    in [lexbuf], calls [f ()], then replaces the token start position
    with the memorized one, thus allowing you to  *)
val expand_token : lexbuf -> (unit -> 'a) -> 'a

(** [fill_lexbuf lexbuf oldlexbuf] fills [oldlexbuf.lex_start_p] and [oldlexbuf.lex_curr_p]
    with data from [lexbuf]. *)
val fill_lexbuf : lexbuf -> Lexing.lexbuf -> unit

(** [location lexbuf] returns a [Location.t], corresponding to
    the current lexeme in [lexbuf]. *)
val location : lexbuf -> Location.t

(** [set_position lexbuf filename line] sets the location information for
    the current position to file [filename], line [line]. Column is not changed. *)
val set_position : lexbuf -> string -> int -> unit

(** [unshift lexbuf] rolls [lexbuf] one character back, but not further than
    the start of the current lexeme. Only works for non-newline ASCII characters. *)
val unshift : lexbuf -> unit
