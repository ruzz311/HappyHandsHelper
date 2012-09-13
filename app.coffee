console.dir     = require('cdir')

# App
express         = require 'express'
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

app = express()
io.listen app

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
app.get '/listen', routes.listen
app.get '/broadcast', routes.broadcast


# ---
console.log "listening on #{port} in #{env} environment"
app.listen port





###
io.sockets.on 'connection', (socket) ->

    socket.on 'alpha_update', (data) ->
        socket.broadcast.emit 'update_a', data

    socket.on 'beta_update', (data) ->
        socket.broadcast.emit 'update_b', data

    socket.on 'gamma_update', (data) ->
        socket.broadcast.emit 'update_g', data

    socket.on 'x_update', (data) ->
        socket.broadcast.emit 'update_x', data

    socket.on 'y_update', (data) ->
        socket.broadcast.emit 'update_y', data

    socket.on 'z_update', (data) ->
        socket.broadcast.emit 'update_z', data
###