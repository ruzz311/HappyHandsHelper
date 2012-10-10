socket              = io.connect('/')
orientation         = []
last_orientation    = []
emit_int            = null
first               = 1
attached            = false

$ ->

    $('#start').click ->

        if !attached

            $.ajax
                type    : 'GET'
                url     : '/broadcast/record'
                data    :
                    broadcast_id    : socket.socket.sessionid
                    secret          : $('#secret').text().trim()

                success : (data) ->
                    attached = true
                    $('.before').hide()
                    $('.recording').show()
                    emit_int = setInterval emit_event, 10

        else
            $('.before').hide()
            $('.recording').show()
            emit_int = setInterval emit_event, 10



    $('#stop').click ->
        first = 1
        clearInterval emit_int
        $('.recording').hide()
        $('.complete').show()



    $('#restart').click ->
        socket.emit 'start_over', 'true'
        $('.complete').fadeOut 'fast', ->
            $('.before').fadeIn 'fast'


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
        console.log orientation
        socket.emit 'orientation_change', orientation


window.ondeviceorientation = (e) ->
    orientation[0] = Math.round(e.alpha*1000)/1000
    orientation[1] = Math.round(e.beta*1000)/1000
    orientation[2] = Math.round(e.gamma*1000)/1000


window.ondevicemotion = (e) ->
    orientation[3] = Math.round(e.accelerationIncludingGravity.x*1000)/1000
    orientation[4] = Math.round(e.accelerationIncludingGravity.y*1000)/1000
    orientation[5] = Math.round(e.accelerationIncludingGravity.z*1000)/1000