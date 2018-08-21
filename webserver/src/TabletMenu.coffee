# External packages
OSC = require 'osc-js'

dataCharacters = require '../data/characters.json'
dataMaps = require '../data/maps.json'

class TabletMenu
    constructor: ()->
        @remote = ""

        @initiatives = ["defaulty"]
        @characters = []
        @npcs = []

        @maps = dataMaps

        @currentTurn = 0

        for character in dataCharacters['PlayerCharacters']
            @characters.push character['name']
        for character in dataCharacters['NPC']
            @npcs.push character['name']
        for character in dataCharacters['Mobs']
            @npcs.push character['name']
        for character in dataCharacters['Creatures']
            @npcs.push character['name']
        
    bindOSC: (oRecv, @oSend, @proj)->
        self = @
        bindRecv = (route, func) ->
            oRecv.on route, (message) ->
                # console.log message
                self.checkHost message
                func message
                self.drawInitiatives()
                self.drawMaps()
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
                bindRecv '/initiative/npc/'+i, ()->
                    # Ignore: user clicks on blank label
                    if i >= self.npcs.length
                        return null
                    # Add character name to initiatives list
                    self.initiatives.push self.npcs[i] # times page?
                    return null
        
        # Bind commands to add a map
        for x in [1..7]
            do (x)->
                i = x-1
                bindRecv  '/image/change/'+i, ()->
                    # Ignore: user clicks on blank map
                    if i >= self.maps.length
                        return null
                    self.proj.changeImage(self.maps[i]['filename'])
    checkHost: (message)->
        if @remote == ""
            @remote = "ip-will-go-here-eventually"
            for i in [0...@characters.length]
                @oSend.send new OSC.Message \
                    '/initiative/labels/pc'+i, @characters[i]
            for i in [0...@npcs.length]
                @oSend.send new OSC.Message \
                    '/initiative/labels/npc'+i, @npcs[i]
    drawMaps: ()->
        for i in [0...7]
            # Set map label
            if i < @maps.length
                @oSend.send new OSC.Message \
                    '/maps/label/'+i, @maps[i]['name']
            else
                @oSend.send new OSC.Message \
                    '/maps/label/'+i, ""
        return null
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
