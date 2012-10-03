url         = require 'url'
connections = []



exports.index = (req, res) -> res.render 'index'
exports.make_listen = (req, res) -> res.render 'make/listen'
exports.test_drive_listen = (req, res) -> res.render 'test_drive/listen'



exports.make = (req, res) ->
    if is_mobile(req)
        res.render 'make/broadcast', {secret : connect_sockets()}
    else
        res.render 'make/listen'



exports.test_drive = (req, res) ->
    if is_mobile(req)
        res.render 'test_drive/broadcast', {secret : connect_sockets()}
    else
        res.render 'test_drive/listen'



exports.make_broadcast = (req, res) ->
    res.render 'make/broadcast', {secret : connect_sockets()}



exports.test_drive_broadcast = (req, res) ->
    res.render 'test_drive/broadcast', {secret : connect_sockets()}



exports.listen_connect = (req, res, next) ->
    url_parts   = url.parse req.url, true
    query       = url_parts.query
    connected   = false

    for connection in connections
        if connection.secret == query.secret
            
            connection.listen_id = query.listen_id
            req.the_one = connection

            if connection.actions
                req.actions = connection.actions
            connected = true
            next()

    if connected == false
        req.err = 'Could not find code, did you enter it correctly?'
        next()



exports.record = (req, res, next) ->
    url_parts   = url.parse req.url, true
    query       = url_parts.query

    for connection in connections
        if connection.secret == query.secret
            if query['actions[]']
                connection.actions = query['actions[]']
            connection.broadcast_id = query.broadcast_id
            req.the_one = connection
            next()



exports.remove_from_array = (id) ->

    for connection in connections
        if connection.broadcast_id == id
            connections.splice _i, 1



is_mobile = (req) ->
    ua = req.headers['user-agent']
    if (/mobile/i.test(ua)) then return true 
    else return false



connect_sockets = (req, res) ->
    rando = random_string(4)

    connections.push
        broadcast_id    : null
        listen_id       : null
        secret          : rando

    return rando



random_string = (len) ->

    char_set    = 'abcdefghijklmnpqrstuvwxyz123456789'
    rando       = ''

    i = 0

    while i < len

        random_pos = Math.floor(Math.random() * char_set.length)
        rando += char_set.substring(random_pos, random_pos + 1)
        i++

    return rando