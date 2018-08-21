# External packages
OSC = require 'osc-js'

module.exports =
    makeServer: (host, port) ->
        return new OSC
            plugin: new OSC.BridgePlugin
                udpServer:
                    host: host
                    port: port
                    exclusive: false
    makeClient: (host, port) ->
        return new OSC
            plugin: new OSC.DatagramPlugin
                send:
                    host: host
                    port: port
