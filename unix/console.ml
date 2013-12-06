(*
 * Copyright (c) 2010-2013 Anil Madhavapeddy <anil@recoil.org>
 *
 * Permission to use, copy, modify, and distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 *)

open Lwt
open Printf

(* TODO everything connects to the same console for now *)
(* TODO management service for logging *)
type t = unit
type id = string
type 'a io = 'a Lwt.t
type error = Invalid_console of string

let connect _id = return (`Ok ())
let disconnect () = return ()

let write t buf off len = prerr_string (String.sub buf off len); flush stderr; len

let create () : t = ()

let write_all t buf off len = return (write t buf off len)

let create_additional_console () = return (create ())

let t =  create ()

let log s = prerr_endline s 

let log_s s =
  let s = s ^ "\n" in
  write_all t s 0 (String.length s) >>= fun (_:int) -> Lwt.return ()
