# External packages
OSC = require 'osc-js'

dataCharacters = require '../data/characters.json'
dataMaps = require '../data/maps.json'

class TabletMenu
    constructor: ()->
        @remote = ""

        @initiatives = ["defaulty"]
        @characters = []

        @currentTurn = 0

        for character in dataCharacters['PlayerCharacters']
            @characters.push character['name']
    bindOSC: (oRecv, @oSend)->
        self = @
        bindRecv = (route, func) ->
            oRecv.on route, (message) ->
                # console.log message
                self.checkHost message
                func message
                self.drawInitiatives()
        bindRecv '/image/change', ()->
        bindRecv '/initiative/clear', ()->
            self.initiatives = []
        bindRecv '/initiative/next', ()->
            if self.currentTurn == null
                self.currentTurn = 0
            else 
                self.currentTurn =
                    (self.currentTurn+1) % self.initiatives.length

        # Bind commands to add a player to the initiative list
        for i in [0..7]
            do (i)->
                bindRecv '/initiative/pc/'+i, ()->
                    # Ignore: user clicks on blank label
                    if i >= self.characters.length
                        return null
                    # Add character name to initiatives list
                    self.initiatives.push self.characters[i] # times page?
                    return null
    checkHost: (message)->
        if @remote == ""
            @remote = "ip-will-go-here-eventually"
            for i in [0...@characters.length]
                @oSend.send new OSC.Message \
                    '/initiative/labels/pc'+i, @characters[i]
    drawInitiatives: ()->
        for i in [0..11]
            # Set initiative label accordingly
            if i < @initiatives.length
                @oSend.send new OSC.Message \
                    '/init/turnTracker/label/'+i, @initiatives[i]
            # ... or as a blank label if nothing exists here
            else
                @oSend.send new OSC.Message \
                    '/init/turnTracker/label/'+i, ""

            # Set turn indicator for this label
            @oSend.send new OSC.Message \
                '/init/turnTracker/'+i, if @currentTurn == i then 0.99 else 0.01
        return null
        

module.exports = TabletMenu
