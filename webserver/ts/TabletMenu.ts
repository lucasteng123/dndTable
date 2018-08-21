class TabletMenu {
    private oscIns: any
    private remote: string

    constructor() {
        this.oscIns = null
        this.remote = ""
    }

    public bindOSC(o: any): void {
        this.oscIns = o

        var binder = function(o: any, m: string, f: any) {
            o.on(m, function (message: object) {
                console.log(message)
            })
        }

        binder(o, '/image/change', function(m: object){})
    }
}

export default TabletMenu
