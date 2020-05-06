import constants, objects, strformat, strutils, options

proc defaultAvatarUrl*(u: User): string =
    result = &"{cdnBase}embeds/avatars/{parseInt(u.discriminator) mod 5}.png"

proc avatarUrl*(u: User; fmt = ""; size = 128): string =
    ## Get's the user's avatar url, you can provide an image format. If user does not have an avatar it will return the default image of the user.
    var ift = fmt
    if fmt == "":
        ift = "jpg"
        if u.avatar.isSome and (get(u.avatar)).startsWith("a_"):
            ift = "gif"
    
    if u.avatar.isNone:
        return defaultAvatarUrl(u)
    result = &"{cdnAvatars}{u.id}/{get(u.avatar)}.{ift}?size={size}"

proc iconUrl*(e: Emoji; fmt = ""; size = 128): string =
    ## Get's the emoji's url, you can provide an image format.
    var ift = fmt
    if fmt == "":
        ift = "png"
        if e.animated: # this field is rather nothing, but trouble.
            ift = "gif"

    result = &"{cdnCustomEmojis}{e.id}.{ift}?size={size}"

proc iconUrl*(g: Guild; fmt = ""; size = 128): string =
    var ift = fmt
    if fmt == "":
        ift = "png"
        if g.icon.isSome and get(g.icon).startsWith("a_"):
            ift = "gif"
    if g.icon.isSome:
        return &"{cdnIcons}{g.id}/{get(g.icon)}.{ift}?size={size}"
    else:
        result = ""

proc `$`*(u: User): string =
    result = &"{u.username}#{u.discriminator}"

proc `@`*(u: User; nick = false): string =
    var n = if nick: "!" else: ""
    result = &"<@{n}{u.id}>"

proc `@`*(r: Role): string =
    result = &"<@{r.id}>"

proc `@`*(g: GuildChannel): string =
    result = &"<#{g.id}>"

proc `$`*(g: GuildChannel): string =
    result = &"#{g.name}"