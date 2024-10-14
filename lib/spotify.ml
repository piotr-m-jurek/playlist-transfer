open Lwt
open Cohttp
open Cohttp_lwt_unix

type access_token_response =
  { access_token : string
  ; token_type : string
  ; expires_in : int
  }
[@@deriving yojson, show]

(* type images =
    { url : string
    ; height : int
    ; width : int
    } *)

(* type profile_response =
    { country : string
    ; display_name : string
    ; email : string
    ; images : images list
    } *)

let get_access_token ~client_id ~client_secret =
  let url = "https://accounts.spotify.com/api/token" in
  let token = "Basic " ^ Base64.encode_string (client_id ^ ":" ^ client_secret) in
  let headers =
    Cohttp.Header.of_list
      [ "Content-Type", "application/x-www-form-urlencoded"; "Authorization", token ]
  in
  let body = Cohttp_lwt.Body.of_form [ "grant_type", [ "client_credentials" ] ] in
  Client.post (Uri.of_string url) ~headers ~body
  >>= fun (_, body) ->
  body
  |> Cohttp_lwt.Body.to_string
  >>= fun body_string ->
  try
    let json = Yojson.Safe.from_string body_string in
    Lwt.return (Ok (access_token_response_of_yojson json |> Result.get_ok))
  with
  | Yojson.Json_error msg -> Lwt.return (Error ("JSON parse error: " ^ msg))
;;

let get_profile ~access_token =
  let uri = "https://api.spotify.com/v1/me" |> Uri.of_string in
  let token = "Bearer " ^ access_token in
  let headers =
    Header.of_list
      [ "Content-Type", "application/x-www-form-urlencoded"; "Authorization", token ]
  in
  Client.get ~headers uri
  >>= fun (status, body) ->
  status
  |> Cohttp.Response.status
  |> Cohttp.Code.code_of_status
  |> Printf.printf "\n\n Status: %d";
  body |> Cohttp_lwt.Body.to_string
;;
