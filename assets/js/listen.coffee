$ ->
    
    $('#start').click ->
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