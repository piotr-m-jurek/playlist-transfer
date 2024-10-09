(lang dune 3.16)

(name playlist_transfer)

(generate_opam_files true)

(source
 (github piotr-m-jurek/playlist-transfer))

(authors "Piotr Małecki-Jurek")

(maintainers "Piotr Małecki-Jurek")

(license MIT)

(documentation https://github.com/piotr-m-jurek/playlist-transfer)

(package
 (name playlist_transfer)
 (synopsis "Move playlists between music services")
 (description "A longer description")
 (depends ocaml dune cohttp-lwt-unix lwt_ssl)
 (tags
  (topics "to describe" your project)))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/reference/dune-project/index.html
