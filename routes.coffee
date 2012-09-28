url         = require 'url'
connections = []


exports.index = (req, res) ->
    ua = req.headers['user-agent']
    if (/mobile/i.test(ua)) then res.redirect '/broadcast'
    else res.render 'index'


exports.listen = (req, res) ->
    res.render 'listen'



exports.listen_connect = (req, res, next) ->
    url_parts   = url.parse req.url, true
    query       = url_parts.query
    connected   = false

    for connection in connections
        if connection.secret == query.secret
            connected = true
            connection.listen_id = query.listen_id
            req.the_one = connection
            next()

    if connected == false
        req.err = 'Could not find code, did you enter it correctly?'
        next()



exports.broadcast = (req, res) ->
    rando = random_string(4)

    connections.push
        broadcast_id    : null
        listen_id       : null
        secret          : rando

    res.render 'broadcast', {secret : rando}



exports.record = (req, res, next) ->
    url_parts   = url.parse req.url, true
    query       = url_parts.query

    for connection in connections
        if connection.secret == query.secret
            connection.broadcast_id = query.broadcast_id
            req.the_one = connection
            next()



exports.go_home = (req, res) ->
    res.render 'index'



exports.test_drive = (req, res) ->
    res.render 'test_drive'



random_string = (len) ->

    char_set    = 'abcdefghijklmnpqrstuvwxyz123456789'
    rando       = ''

    i = 0

    while i < len

        random_pos = Math.floor(Math.random() * char_set.length)
        rando += char_set.substring(random_pos, random_pos + 1)
        i++

    return rando