socket      = io.connect('/')
orientation = []
last_orientation = []
emit_int    = null
first       = 1

$ ->

    $('#start').click ->

        $('.overlay').fadeIn()

        $.ajax
            type    : 'GET'
            url     : '/broadcast/record'
            data    :
                broadcast_id    : socket.socket.sessionid
                secret          : $('#secret').text().trim()

            success : (data) ->
                $('.overlay').fadeOut()
                $('.before').fadeOut 'fast', ->
                    emit_int = setInterval emit_event, 10
                    $('.recording').fadeIn('fast')



    $('#stop').click ->
        clearInterval emit_int
        $('.recording').fadeOut 'fast', ->
            $('.complete').fadeIn('fast')



    $('#restart').click ->
        socket.emit 'start_over', 'true'
        $('.complete').fadeOut 'fast', ->
            $('.before').fadeIn('fast')


emit_event = (pos) ->

    if first
        for item in orientation
            last_orientation[_i] = item
        first = 0

    pass = 0
    for item in orientation
        if (Math.abs(item - last_orientation[_j])) > 5
            pass = 1
            last_orientation[_j] = item

    if pass
        socket.emit 'orientation_change', orientation


window.ondeviceorientation = (e) ->
    orientation[0] = Math.round(e.alpha*100)/100
    orientation[1] = Math.round(e.beta*100)/100
    orientation[2] = Math.round(e.gamma*100)/100


window.ondevicemotion = (e) ->
    orientation[3] = Math.round(e.acceleration.x*100)/100
    orientation[4] = Math.round(e.acceleration.y*100)/100
    orientation[5] = Math.round(e.acceleration.z*100)/100
    orientation[6] = Math.round(e.accelerationIncludingGravity.x*100)/100
    orientation[7] = Math.round(e.accelerationIncludingGravity.y*100)/100
    orientation[8] = Math.round(e.accelerationIncludingGravity.z*100)/100