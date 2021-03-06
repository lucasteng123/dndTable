# Internal packages
Server = require './Server'
TabletMenu = require './TabletMenu'
OSCFactory = require './OSCFactory'
OSCRelay = require './OSCRelay'
Projector = require './Projector'

# Internal objects
l = require './logger'

port = process.env.PORT || 3000

server = new Server()

server.express.listen port, (err) ->
    if err
        l.log l.ERROR, err

    l.log l.INFO, l.Msg.ListeningHTTP

oscThis = OSCFactory.makeServer('0.0.0.0', 9000)
oscProj = OSCFactory.makeClient('192.168.2.21', 12000)
oscMenu = OSCFactory.makeClient('10.42.0.238', 9004)
# oscMenu = OSCFactory.makeClient('127.0.0.1', 9004)

proj = new Projector(oscProj)

# Add tablet menu controller
new TabletMenu().bindOSC(oscThis, oscMenu, proj)

oscThis.on 'open', ()->
    l.log l.INFO, l.Msg.ListeningOSC

# oscThis.on '/move/left', (message)-> console.log message
paths = ['/move/left','/move/right']
new OSCRelay(oscThis, oscProj, paths).bind()

oscThis.open()
