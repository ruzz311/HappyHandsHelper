socket  = io.connect('/')

class View

    constructor : (action) ->
        template = JadeTemplates['templates/action']
        @view = template({'name' : action })

    load : ->
        $('.listening').empty()
        $('.listening').html(@view)


$ ->
    view = new View 'Uppercut'
    view.load()

    $(window).keydown (e) ->
        if e.keyCode == 13
            for wrapper in $('.wrapper')
                if $(wrapper).is(':visible')
                    $(wrapper).find('.btn').trigger('click')


    $('#start').click ->

        $('.alert').fadeOut 'fast'

        $.ajax
            type    : 'GET'
            url     : '/listen/connect'
            data    :
                listen_id   : socket.socket.sessionid
                secret      : $('#secret').val().trim()

            success : (message) ->
                if message.error
                    $('.alert').find('.message').text message.error
                    $('.alert').fadeIn 'fast'

                else
                    $('.alert').fadeOut 'fast'
                    $('.before').fadeOut 'normal', ->
                        $('.listening').fadeIn()

            error   : (err) ->
                $('.alert').find('.message').text 'Some unknown error occured'
                $('.alert').fadeIn 'fast'



socket.on 'next_view', (name) ->
    view = new View name
    view.load()



socket.on 'success', ->
    $('h2').addClass('bounce')
    setTimeout (->
        $('h2').removeClass('bounce')
    ), 150
    console.log 'success'
