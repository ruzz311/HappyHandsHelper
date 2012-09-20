socket = io.connect('/')

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
                    $('.recording').fadeIn('fast')



    $('#stop').click ->
        #kill socket
        $('.recording').fadeOut 'fast', ->
            $('.complete').fadeIn('fast')



    $('#restart').click ->
        $('.complete').fadeOut 'fast', ->
            $('.before').fadeIn('fast')

                

window.emit_event = (pos) ->
    socket.emit 'orientation_change', pos