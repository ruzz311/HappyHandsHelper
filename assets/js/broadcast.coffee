$ ->
    
    socket_id = 0


    $('#start').click ->

        $('.overlay').fadeIn()

        $.ajax
            type    : 'GET'
            url     : '/broadcast/record'
            success : (data) ->
                #init socket
                $('.overlay').fadeOut()
                $('.before').fadeOut 'fast', ->
                    $('.recording').fadeIn('fast')



    $('#stop').click ->
        #kill socket
        $('.recording').fadeOut 'fast', ->
            $('.complete').fadeIn('fast')



    $('#restart').click ->

        $('.overlay').fadeIn()

        $.ajax
            type    : 'GET'
            url     : '/broadcast/new_session'
            success : (data) ->
                $('.overlay').fadeOut()
                $('.before').find('h2').find('span').text(data.rando)
                $('.complete').fadeOut 'fast', ->
                    $('.before').fadeIn('fast')