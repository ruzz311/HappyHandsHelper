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
app.get '/home', routes.go_home

app.get '/listen', routes.listen
app.get '/listen/connect', routes.listen_connect, (req, res) ->
    io.sockets.sockets[req.the_one.broadcast_id].on 'orientation_change', (position) ->
        io.sockets.sockets[req.the_one.listen_id].emit 'update_data', position
    res.send {'listening' : true}

app.get '/broadcast', routes.broadcast
app.get '/broadcast/record', routes.record, (req, res) ->
    res.send {'recording' : true}


# ---
console.log "listening on #{port} in #{env} environment"
server.listen port