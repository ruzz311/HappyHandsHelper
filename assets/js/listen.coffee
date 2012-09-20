socket = io.connect('/')

$ ->
    
    $('#start').click ->

        $('.overlay').fadeIn()

        $.ajax
            type    : 'GET'
            url     : '/listen/connect'
            data    :
                listen_id   : socket.socket.sessionid
                secret      : $('#secret').val().trim()

            success : ->
                $('.overlay').fadeIn()
                $('.before').fadeOut 'normal', ->
                    $('.recording').fadeIn()



    $('#restart').click (e) ->
        e.preventDefault()
        if confirm('Are you sure you want to restart? This information is not stored and you will lose this information')
            $('.complete').fadeOut 'normal', ->
                $('.before').find('input').val('')
                $('.before').fadeIn()



    recording_complete = ->
        $('.recording').fadeOut 'normal', ->
            $('.complete').fadeIn()


socket.on 'update_data', (positions) ->

    template = '['
    for position in positions
        template += position
    template += '],'

    $('#dump').append template