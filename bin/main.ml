open Lwt
open Cohttp
open Cohttp_lwt_unix

let _body =
  Client.get (Uri.of_string "https://example.com")
  >>= fun (resp, body) ->
  let _ =
    Printf.printf "response code %d" (resp |> Response.status |> Code.code_of_status)
  in
  body |> Cohttp_lwt.Body.to_string
;;

(*
   export async function getAccessToken(clientId: string, code: string): Promise<string> {
    const verifier = localStorage.getItem("verifier");

    const params = new URLSearchParams();
    params.append("client_id", clientId);
    params.append("grant_type", "authorization_code");
    params.append("code", code);
    params.append("redirect_uri", "http://localhost:5173/callback");
    params.append("code_verifier", verifier!);

    const result = await fetch("https://accounts.spotify.com/api/token", {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: params
    });

    const { access_token } = await result.json();
    return access_token;
}
*)

let get_access_token ~(client_id : string) ~client_secret =
  Client.post
    (Uri.of_string "https://accounts.spotify.com/api/token")
    ~headers:(Header.init_with "Content-Type" "application/x-www-form-urlencoded")
    ~body:
      (Cohttp_lwt.Body.of_form
         [ "client_id", [ client_id ]
         ; "grant_type", [ "authorization_code" ]
         ; "code", [ client_secret ]
         ; "redirect_uri", [ "http://localhost:5173/callback" ]
         ; "code_verifier", [ "verifier" (* TODO: WTH is verifier*) ]
         ])
  >>= fun (resp, body) ->
  let _ =
    Printf.printf "response code %d" (resp |> Response.status |> Code.code_of_status)
  in
  body |> Cohttp_lwt.Body.to_string
;;

let () =
  Dotenv.export () |> ignore;
  let client_id = Sys.getenv "SPOTIFY_CLIENT_ID" in
  let client_secret = Sys.getenv "SPOTIFY_CLIENT_SECRET" in
  (* let body = Lwt_main.run body in *)
  (* print_endline ("Received body:\n" ^ body); *)
  print_endline "\n===SPOTIFY CLI===\n";
  print_endline ("Client ID: \n" ^ client_id);
  print_endline ("Client Secret: \n" ^ client_secret)
;;
