# External packages
OSC = require 'osc-js'

module.exports = class
    constructor: (@oSend)->
    changeImage: (filename)->
        @oSend.send new OSC.Message '/image/change/', filename
