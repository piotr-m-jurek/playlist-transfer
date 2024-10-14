Dotenv.export () |> ignore

let get_client_id () = Sys.getenv "SPOTIFY_CLIENT_ID"
let get_client_secret () = Sys.getenv "SPOTIFY_CLIENT_SECRET"
