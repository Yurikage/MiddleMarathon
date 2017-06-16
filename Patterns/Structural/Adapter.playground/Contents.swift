/*In software engineering, structural design patterns are design patterns that ease the design by identifying a simple way to realize relationships between entities.*/

//Example 1

protocol BirdProtocol {
    func sing()
    func fly()
}

class Bird: BirdProtocol {
    func sing() {
        print("Tew-tew-tew")
    }
    
    func fly() {
        print("ONG! I am flying!")
    }
}

class Raven {
    func flySearchAndDestroy() {
        print("I am flying and seak for killing!")
    }
    
    func voice() {
        print("Kaaaar-kaaaar-kaaaaaar!")
    }
}

class RavenAdapter: BirdProtocol {
    private var raven: Raven
    
    init(adaptee: Raven) {
        raven = adaptee
    }
    
    func sing() {
        raven.voice()
    }
    
    func fly() {
        raven.flySearchAndDestroy()
    }
}

func makeTheBirdTest(bird: BirdProtocol) {
    bird.fly()
    bird.sing()
}

let simpleBird = Bird()
let simpleRaven = Raven()

let ravenAdapter = RavenAdapter(adaptee: simpleRaven)

makeTheBirdTest(bird: simpleBird)
makeTheBirdTest(bird: ravenAdapter)

//Example 2

protocol Charger {
    func charge()
}

protocol EuropeanNotebookChargeDelegate {
    func chargetNotebookRoundHoles(charger: Charger)
}

extension EuropeanNotebookChargeDelegate {
    func chargetNotebookRoundHoles(charger: Charger) {
        print("Charging with 220 and round holes!")
    }
}

class EuropeanNotebookCharger: Charger, EuropeanNotebookChargeDelegate {
    
    var delegate: EuropeanNotebookChargeDelegate!
    
    init() {
        delegate = self
    }
    
    func charge() {
        delegate.chargetNotebookRoundHoles(charger: self)
    }
}

class USANotebookCharger {
    func chargeNotebookRectHoles() {
        print("Charge Notebook Rect Holes")
    }
}

class USANotebookEuropeanAdapter: Charger, EuropeanNotebookChargeDelegate {
    var usaCharger: USANotebookCharger!
    
    init(charger: USANotebookCharger) {
        usaCharger = charger
    }
    
    func chargetNotebookRoundHoles(charger: Charger) {
        usaCharger.chargeNotebookRectHoles()
    }
    
    func charge() {
        let euroChange = EuropeanNotebookCharger()
        euroChange.delegate = self
        euroChange.charge()
    }
}

func makeTheNotebookCharge(charger: Charger) {
    charger.charge()
}

let euroCharger = EuropeanNotebookCharger()
makeTheNotebookCharge(charger: euroCharger)

let charger = USANotebookCharger()
let adapter = USANotebookEuropeanAdapter(charger: charger)
makeTheNotebookCharge(charger: adapter)