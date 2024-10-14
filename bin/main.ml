open Playlist_transfer

let () =
  print_endline "\n===SPOTIFY CLI===\n";
  let client_id = Env.get_client_id () in
  let client_secret = Env.get_client_secret () in
  let token_response =
    Spotify.get_access_token ~client_id ~client_secret |> Lwt_main.run
  in
  Result.get_ok token_response |> Spotify.show_access_token_response |> Printf.printf "%s";
  let token = (Result.get_ok token_response).access_token in
  let user_profile = Spotify.get_profile ~access_token:token |> Lwt_main.run in
  print_endline ("Received body:\n" ^ user_profile)
;;
