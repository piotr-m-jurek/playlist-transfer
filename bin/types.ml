module Private_user = struct
  type explicit_content =
    { filter_enabled : bool
    ; filter_locked : bool
    }

  type external_urls = { spotify : string }

  type followers =
    { href : string
    ; total : int
    }

  type image =
    { url : string
    ; height : int
    ; width : int
    }

  type t =
    { country : string
    ; display_name : string
    ; email : string
    ; explicit_content : explicit_content
    ; external_urls : external_urls
    ; followers : followers
    ; href : string
    ; id : string
    ; images : image list
    ; product : string
    ; resource_type : string (* from original is User.type: string*)
    ; uri : string
    }
end
