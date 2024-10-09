open Lwt
open Cohttp
open Cohttp_lwt_unix

(* type _user_profile = *)
(*   { country : string *)
(*   ; display_name : string *)
(*   ; email : string *)
(*   ; _type : string *)
(*   ; uri : string *)
(*   ; href : string *)
(*   ; id : string *)
(*   ; product : string *)
(*   } *)

let body =
  Client.get (Uri.of_string "https://example.com")
  >>= fun (resp, body) ->
  let _ =
    Printf.printf "response code %d" (resp |> Response.status |> Code.code_of_status)
  in
  body |> Cohttp_lwt.Body.to_string
;;

let () =
  let body = Lwt_main.run body in
  print_endline ("Received body:\n" ^ body)
;;
