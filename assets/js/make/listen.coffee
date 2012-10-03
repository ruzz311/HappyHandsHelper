ZeroClipboard.setMoviePath( '/js/ZeroClipboard10.swf' )

socket      = io.connect('/')
$dom_dump   = null
$arr_dump   = null
$records    = null
clip        = null

$ ->

    $dom_dump   = $('#dump')
    $arr_dump   = $('#arr_dump')
    $records    = $('.records')

    #--- copy to clipboard
    clip = new ZeroClipboard.Client()
    clip.setHandCursor true

    clip.glue 'clip_button', 'clip_container'
    clip.addEventListener 'mouseOver', ->
        text        = $arr_dump.text()
        clip_text   = text.substring(0, text.length - 1);
        clip_text   = "[#{clip_text}]"
        clip.setText clip_text

    clip.addEventListener 'complete', (client, text) ->
        alert 'copied to clipboard'
    #---

    
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
                        $('#clip_container').css 'opacity', 1

            error   : (err) ->
                $('.alert').find('.message').text 'Some unknown error occured'
                $('.alert').fadeIn 'fast'


    $('.alert').find('.close').click ->
        $('.alert').fadeOut 'fast', ->


socket.on 'update_data', (positions) ->

    arr_template = '['
    dom_template = '<tr>'

    for position in positions
        dom_template += "<td>#{position}</td>"

        if _i == positions.length - 1
            arr_template += "#{position}"
        else arr_template += "#{position},"

    arr_template += '],'
    dom_template += '</tr>'

    $dom_dump.append dom_template
    $arr_dump.append arr_template
    $records.scrollTop 10000000000


socket.on 'start_over', (data) ->
    $dom_dump.empty()
    $arr_dump.empty()