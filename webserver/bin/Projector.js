// Generated by CoffeeScript 2.3.1
(function() {
  // External packages
  var OSC;

  OSC = require('osc-js');

  module.exports = class {
    constructor(oSend) {
      this.oSend = oSend;
    }

    changeImage(dest, filename) {
      return this.oSend.send(new OSC.Message('/image/change/' + dest, filename));
    }

  };

}).call(this);
