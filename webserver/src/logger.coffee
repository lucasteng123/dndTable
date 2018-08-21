module.exports =
    INFO:  "info"
    ERROR: "erro"
    Msg:
        ListeningHTTP: "Listening to HTTP..."
        ListeningOSC: "Listening to OSC..."
    log: (type, message)->
        console.log '['+type+'] ' + message
