class View

    constructor : (@action) ->
        template = JadeTemplates['templates/action']
        @view = template({'name' : action.name })

    make : ->
        hands.on @action.records, (=>
            next_view()
        ),
        kill_on_complete : true
        $('#view_wrap').empty()
        $('#view_wrap').html(@view)

    kill : ->
        return false


hands   = new HappyHands()
index   = 0
views   = []
actions = [
    name    : 'Uppercut'
    records : [[13.45,79.2,-41.88,-3.77,-11.74,-2.83],[26.89,81.46,-59.44,-6.53,-14.18,-2.12],[66.68,83.51,-105.75,-7.1,-13.6,0.03],[110.63,80.26,-158.55,-6.81,-12.23,1.83],[127.35,76.03,173.34,-5.42,-9.76,0.86],[131.72,71.15,153.84,-4.75,-6.85,1.66],[135.96,68.49,115.64,0.5,-1.66,0.83],[142.87,72.07,92.19,1.24,0.18,2.29],[206.99,64.46,0.72,-2.96,10.01,-3.28],[220.43,49.47,-22.18,-2.03,14.71,-10.73],[232.37,34,-43.14,-4.78,19.8,-0.86],[239.83,7.29,-54.52,-16.95,19.57,-12.58],[243.57,-20.14,-58.93,-18.85,19.53,-20.65],[262.37,-43.38,-53.85,-10.85,19.67,-20.42],[313.59,-58,-16.5,-8.81,19.71,-20.36],[1.39,-37.07,12.99,-18.74,19.53,-20.64],[8.35,-7.01,12.18,-1.51,19.84,-20.15],[7.59,26.59,12.61,-9.49,19.69,-20.38],[351.82,59.5,28.31,-8.85,19.71,-17.67],[284.25,72.23,95.83,6.3,20,4.75],[240.52,65.92,143.28,-3.06,14.97,13.12],[226.66,63.68,161.18,-2.16,6.23,13.99],[218.66,66.02,170.27,-6.1,-0.02,4.21],[211.6,66.36,179.19,-2.02,-8.93,3.21],[209.44,66.05,-176.13,-2.68,-9.64,4.92],[204.35,71.34,-174.43,-0.45,-8.91,4.6]]
,
    name    : 'Shoot'
    records : []
,
    name    : 'Slice'
    records : []
,
    name    : 'Punch'
    records : [[207.21,32.85,-7.74,-1.35,-11.37,-5.69],[207.21,32.85,-7.74,-1.35,-11.37,-5.69],[204.8,31.37,-18.83,-1.86,-5.91,-1.4],[204.8,31.37,-18.83,-1.86,-5.91,-1.4],[197.84,21.59,-30.99,-7.17,12.23,-11.54],[197.84,21.59,-30.99,-7.17,12.23,-11.54],[191.12,14.79,-37.84,-2.53,1.63,-20.11],[191.12,14.79,-37.84,-2.53,1.63,-20.11],[194.96,16.71,-36.37,-11.13,0.19,0.4],[194.96,16.71,-36.37,-11.13,0.19,0.4],[193.9,15.53,-38.44,-7.02,-1.39,-12.65],[193.9,15.53,-38.44,-7.02,-1.39,-12.65],[194.56,16.58,-38.33,-5.34,-2.38,-6.68],[194.56,16.58,-38.33,-5.34,-2.38,-6.68],[194.93,18.44,-39.63,-6.26,-3.38,-7.39],[194.93,18.44,-39.63,-6.26,-3.38,-7.39],[195.59,20.26,-39.21,-5.96,-3.47,-7.61],[195.59,20.26,-39.21,-5.96,-3.47,-7.61],[196.35,21.14,-39.79,-5.77,-3.55,-7.05],[196.35,21.14,-39.79,-5.77,-3.55,-7.05]]
,
    name    : 'Slap'
    records : []
,
    name    : 'Slap a Ho'
    records : []
]


$ ->
    for action in actions
        view = new View action
        views.push view

    views[0].make()



window.next_view = ->
    if index < views.length - 1 then index++
    else index = 0

    views[index].kill()
    views[index].make()



window.prev_view = ->
    if index > 0 then index--
    else index = views.length - 1

    views[index].kill()
    views[index].make()