# App
console.dir     = require 'cdir'
express         = require 'express'
http            = require 'http'
path            = require 'path'
stylus          = require 'stylus'
nib             = require 'nib'
jadeAssets      = require 'connect-assets-jade'
assets          = require 'connect-assets'
io              = require 'socket.io'
routes          = require './routes'
port            = process.env.PORT || 3000
env             = process.env.environment || 'development'


# Express Configuration
app     = express()
server  = http.createServer(app)
io      = io.listen server

app.use assets()
app.use express.logger 'dev'
app.use express.static path.join __dirname, 'public'
app.use assets(jsCompilers:
  jade: jadeAssets()
)

app.set 'views', path.join __dirname, 'views'
app.set 'view engine', 'jade'


# Routes
app.get '/', routes.index
app.get '/make', routes.make
app.get '/make/listen', routes.make_listen
app.get '/make/broadcast', routes.make_broadcast
app.get '/test_drive', routes.test_drive
app.get '/test_drive/listen', routes.test_drive_listen
app.get '/test_drive/broadcast', routes.test_drive_broadcast



app.get '/listen/connect', routes.listen_connect, (req, res) ->
    if !req.err
        res.send {'listening' : true}
    else
        res.send {'error' : req.err}



app.get '/broadcast/record', routes.record, (req, res) ->

    io.sockets.sockets[req.the_one.broadcast_id].on 'disconnect', (socket) ->
        routes.remove_from_array req.the_one.broadcast_id
    
    io.sockets.sockets[req.the_one.broadcast_id].on 'orientation_change', (position) ->
        if req.the_one.listen_id
            io.sockets.sockets[req.the_one.listen_id].emit 'update_data', position

    io.sockets.sockets[req.the_one.broadcast_id].on 'start_over', (position) ->
        if req.the_one.listen_id
            io.sockets.sockets[req.the_one.listen_id].emit 'start_over', position

    io.sockets.sockets[req.the_one.broadcast_id].on 'next_view', (name) ->
        if req.the_one.listen_id
            io.sockets.sockets[req.the_one.listen_id].emit 'next_view', name

    io.sockets.sockets[req.the_one.broadcast_id].on 'test_drive_success', (name) ->
        if req.the_one.listen_id
            io.sockets.sockets[req.the_one.listen_id].emit 'success', name

    res.send {'recording' : true}


# ---
console.log "listening on #{port} in #{env} environment"
server.listen port