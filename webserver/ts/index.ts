import server from './Server'
import TabletMenu from './TabletMenu'
import OSC from "osc-js"

const port = process.env.PORT || 3000

server.listen(port, (err : Error) => {
    if (err) {
        return console.log(err);
    }

    return console.log("doin' a listen")
})

var oscConf: any = {
    uspServer: {
        host: '0.0.0.0',
        port: 9000,
        exclusive: false,
    },
    udpClient: {
        host: '127.0.0.1',
        port: 9004,
    },
    receiver: 'udp'
}

var bleg = new TabletMenu()
var oscPlugin = new OSC.BridgePlugin(oscConf)
var osc = new OSC(oscPlugin)
bleg.bindOSC(osc)
osc.open()
