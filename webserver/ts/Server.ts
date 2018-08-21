import express from "express";

class Server {
    public expressApp: express.Application

    constructor() {
        this.expressApp = express()
        this.bindRoutes()
    }

    private bindRoutes(): void {
        const router = express.Router()
        router.get('/', (req, res) => {
            res.json({
                message: 'Hey yo world'
            })
        })
        this.expressApp.use('/', router)
    }
}

export default new Server().expressApp
