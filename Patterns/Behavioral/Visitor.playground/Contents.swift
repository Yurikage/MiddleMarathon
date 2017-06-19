/*The visitor pattern is used to separate a relatively complex set of structured data classes from the functionality that may be performed upon the data that they hold.*/
//Example 1

class WarehouseItem {
    let name: String
    let isBroken: Bool
    let price: Int
    
    init(name: String, isBroken: Bool, price: Int) {
        self.name = name
        self.isBroken = isBroken
        self.price = price
    }
}

class Warehouse {
    private var itemsArray = [WarehouseItem]()
    
    func addItem(item: WarehouseItem) {
        itemsArray.append(item)
    }
    
    func accept(visitor: BasicVisitor) {
        for item in itemsArray {
            visitor.visit(object: item)
        }
    }
}

protocol BasicVisitor {
    func visit(object: AnyObject)
}

class QualityCheckerVisitor: BasicVisitor {
    func visit(object: AnyObject) {
        switch object {
        case let item as WarehouseItem:
            if item.isBroken {
                print("Item: \(item.name) is broken")
            } else {
                print("Item: \(item.name) is pretty cool!")
            }
        default:
            break
        }
    }
}

class PriceCheckerVisitor: BasicVisitor {
    func visit(object: AnyObject) {
        switch object {
        case let item as WarehouseItem:
            print("Item: \(item.name) have price = \(item.price)")
        default:
            break
        }
    }
}

let localWarehouse = Warehouse()
localWarehouse.addItem(item: WarehouseItem(name: "Item1", isBroken: false,
                                           price: 25))
localWarehouse.addItem(item: WarehouseItem(name: "Item2", isBroken: false,
                                           price: 32))
localWarehouse.addItem(item: WarehouseItem(name: "Item3", isBroken: true,
                                           price: 45))
localWarehouse.addItem(item: WarehouseItem(name: "Item4", isBroken: false,
                                           price: 33))
localWarehouse.addItem(item: WarehouseItem(name: "Item5", isBroken: false,
                                           price: 12))
localWarehouse.addItem(item: WarehouseItem(name: "Item6", isBroken: true,
                                           price: 78))
localWarehouse.addItem(item: WarehouseItem(name: "Item7", isBroken: true,
                                           price: 34))
localWarehouse.addItem(item: WarehouseItem(name: "Item8", isBroken: false,
                                           price: 51))
localWarehouse.addItem(item: WarehouseItem(name: "Item9", isBroken: false,
                                           price: 25))

let visitor = PriceCheckerVisitor()
let qualityVisitor = QualityCheckerVisitor()

localWarehouse.accept(visitor: visitor)
localWarehouse.accept(visitor: qualityVisitor)

//Example 2
protocol PlanetVisitor {
    func visit(planet: PlanetAlderaan)
    func visit(planet: PlanetCoruscant)
    func visit(planet: PlanetTatooine)
    func visit(planet: MoonJedah)
}

protocol Planet {
    func accept(visitor: PlanetVisitor)
}

class MoonJedah: Planet {
    func accept(visitor: PlanetVisitor) { visitor.visit(planet: self) }
}

class PlanetAlderaan: Planet {
    func accept(visitor: PlanetVisitor) { visitor.visit(planet: self) }
}

class PlanetCoruscant: Planet {
    func accept(visitor: PlanetVisitor) { visitor.visit(planet: self) }
}

class PlanetTatooine: Planet {
    func accept(visitor: PlanetVisitor) { visitor.visit(planet: self) }
}

class NameVisitor: PlanetVisitor {
    var name = ""
    
    func visit(planet: MoonJedah) { name = "Jedah" }
    func visit(planet: PlanetAlderaan) { name = "Alderaan" }
    func visit(planet: PlanetTatooine) { name = "Tatooine" }
    func visit(planet: PlanetCoruscant) { name = "Coruscant" }
}

let planets: [Planet] = [PlanetAlderaan(), PlanetCoruscant(), PlanetTatooine(), MoonJedah()]

let name = planets.map { (planet: Planet) -> String in
    let visitor = NameVisitor()
    planet.accept(visitor: visitor)
    
    return visitor.name
}

print(name)