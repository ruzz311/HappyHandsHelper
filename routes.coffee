exports.index = (req, res) ->
    ua = req.headers['user-agent']
    if (/mobile/i.test(ua)) then res.redirect '/broadcast'
    else res.redirect '/listen'

exports.listen = (req, res) ->
    res.render 'listen'

exports.broadcast = (req, res) ->
    res.render 'broadcast', {rando : random_string(4)}

exports.record = (req, res) ->
    res.send {'recording' : true}

exports.go_home = (req, res) ->
    res.render 'index'

exports.new_broadcast_session = (req, res) ->
    res.send {rando : random_string(4)}



random_string = (len) ->

    char_set    = 'abcdefghijklmnopqrstuvwxyz0123456789'
    rando       = ''

    i = 0

    while i < len

        random_pos = Math.floor(Math.random() * char_set.length)
        rando += char_set.substring(random_pos, random_pos + 1)
        i++

    return rando