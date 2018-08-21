// Generated by CoffeeScript 2.3.1
(function() {
  // External packages
  var OSC;

  OSC = require('osc-js');

  module.exports = {
    makeServer: function(host, port) {
      return new OSC({
        plugin: new OSC.BridgePlugin({
          udpServer: {
            host: host,
            port: port,
            exclusive: false
          }
        })
      });
    },
    makeClient: function(host, port) {
      return new OSC({
        plugin: new OSC.DatagramPlugin({
          send: {
            host: host,
            port: port
          }
        })
      });
    }
  };

}).call(this);
