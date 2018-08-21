# External packages
OSC = require 'osc-js'

class OSCRelay
    constructor: (@from, @to, @paths) ->
    bind: ()->
        self = @
        for path in @paths
            (()->
                thisPath = path # fucking lexical scoping
                self.from.on path, (message)->
                    console.log thisPath
                    self.to.send new OSC.Message thisPath, message.args...
            )()

module.exports = OSCRelay
