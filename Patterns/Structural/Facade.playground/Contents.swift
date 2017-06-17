/*The facade pattern is used to define a simplified interface to a more complex subsystem.*/

//Example 1
class PathFinder {
    func findCurrentLocation() {
        print("Finding you location. Hmmm, here you are!")
    }
    
    func findLocationToTravel(location: String) {
        print("So you wanna travell to " + location)
    }
    
    func makeARoute() {
        print("Okay, to travell to this location we are using google maps....")
    }
}

class TravellEngine {
    func findTransport() {
        print("Okay, to travell there you will probabply need dragon! Arghhhhhh")
    }
    
    func orderTransport() {
        print("Maaaam, can I order a dragon?... Yes... Yes, green one... with fire!... No, not a dragon of death... Thank you!")
    }
    
    func travel() {
        print("Maan, you are flying on dragon!")
    }
}

class TicketPrinitingSystem {
    func createTicket() {
        print("Connecting to our ticketing system...")
    }
    
    func printiongTicket() {
        print("Hmmm, ticket for travelling on the green dragon. Iteresting...")
    }
}

class TravellSystemFacade {
    func travellTo(location: String) {
        let pf = PathFinder()
        let te = TravellEngine()
        let tp = TicketPrinitingSystem()
        
        pf.findCurrentLocation()
        pf.findLocationToTravel(location: location)
        pf.makeARoute()
        
        te.findTransport()
        te.orderTransport()
        
        tp.createTicket()
        tp.printiongTicket()
        
        te.travel()
    }
}

let facade = TravellSystemFacade()
facade.travellTo(location: "Lviv")

//Example 2
import Foundation

enum Eternal {
    static func set(_ object: Any, forKey defaultName: String) {
        let defaults: UserDefaults = UserDefaults.standard
        defaults.set(object, forKey: defaultName)
        defaults.synchronize()
    }
    
    static func object(forKey key: String) -> AnyObject! {
        let defaults: UserDefaults = UserDefaults.standard
        return defaults.object(forKey: key) as AnyObject!
    }
}

Eternal.set("Disconnect me. I'd rather be nothing", forKey: "Bishop")
Eternal.object(forKey: "Bishop")