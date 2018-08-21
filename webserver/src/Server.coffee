express = require 'express'

class Server
    constructor: () ->
        @express = express()
    bind: ()->
        router = express.Router()
        router.get '/', (req, res) ->
            res.json
                message: "Hey yo world"
        @express.use '/', router

module.exports = Server
