# External packages
OSC = require 'osc-js'

module.exports = class
    constructor: (@oSend)->
    changeImage: (dest, filename)->
        @oSend.send new OSC.Message '/image/change/'+dest, filename
