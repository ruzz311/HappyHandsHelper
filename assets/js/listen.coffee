socket      = io.connect('/')
$dump       = null
$records    = null

$ ->
    
    $dump       = $('#dump')
    $records    = $('.records')
    
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
                        $('.recording').fadeIn()

            error   : (err) ->
                $('.alert').find('.message').text 'Some unknown error occured'
                $('.alert').fadeIn 'fast'



    $('#restart').click (e) ->
        e.preventDefault()
        if confirm('Are you sure you want to restart? This information is not stored and you will lose this information')
            $('.complete').fadeOut 'normal', ->
                $('.before').find('input').val('')
                $('.before').fadeIn()



    $('.alert').find('.close').click ->
        $('.alert').fadeOut 'fast', ->



    recording_complete = ->
        $('.recording').fadeOut 'normal', ->
            $('.complete').fadeIn()


socket.on 'update_data', (positions) ->

    ###
    template = '<div>['
    for position in positions
        if _i == positions.length - 1
            template += "#{position}"
        else
            template += "#{position},"
    template += '],</div>'
    ###

    template = '<tr>'
    for position in positions
        template += "<td>#{position}</td>"
    template += '</tr>'

    $dump.append template
    $records.scrollTop 10000000000

socket.on 'start_over', (data) ->
    $dump.empty()