/*The composite pattern is used to create hierarchical, recursive tree structures of related objects where any element of the structure may be accessed and utilised in a standard manner.*/

protocol CompositeObjectProtocol {
    func getData() -> String
    func addComponent(component: CompositeObjectProtocol)
}

class LeafObject: CompositeObjectProtocol {
    
    var leafValue: String!
    
    func getData() -> String {
        return "\n" + "<\(leafValue!)>"
    }
    
    func addComponent(component: CompositeObjectProtocol) {
        print("Can't add component. Sorry, man")
    }
}

class Container: CompositeObjectProtocol {
    
    private var components = [CompositeObjectProtocol]()
    
    func getData() -> String {
        var valueToReturn = "<ContainerValue>"
        
        for component in components {
            valueToReturn += component.getData() + "\n"
        }
        
        valueToReturn += "</ContainerValues>"
        
        return valueToReturn
    }
    
    func addComponent(component: CompositeObjectProtocol) {
        components.append(component)
    }
}

let rootContainer = Container()
let object = LeafObject()
object.leafValue = "Level1 value"
rootContainer.addComponent(component: object)

let firstLevelContainer1 = Container()
let object2 = LeafObject()
object2.leafValue = "Level2 value"
firstLevelContainer1.addComponent(component: object2)
rootContainer.addComponent(component: firstLevelContainer1)

let firstLevelContainer2 = Container()
let object3 = LeafObject()
object3.leafValue = "level2 value 2"
firstLevelContainer2.addComponent(component: object3)
rootContainer.addComponent(component: firstLevelContainer2)

print(rootContainer.getData())

//Example 2
protocol Shape {
    func draw(fillColor: String)
}

final class Circle: Shape {
    
    func draw(fillColor: String) {
        print("Drawing a circle with color \(fillColor)")
    }
    
}

final class Square: Shape {
    
    func draw(fillColor: String) {
        print("Drawing a square with color \(fillColor)")
    }
    
}

final class Whiteboad: Shape {
    
    lazy var shapes = [Shape]()
    
    init(_ shapes: Shape...) {
        self.shapes = shapes
    }
    
    func draw(fillColor: String) {
        for shape in shapes {
            shape.draw(fillColor: fillColor)
        }
    }
    
}

var whiteboard = Whiteboad(Circle(), Square())
whiteboard.draw(fillColor: "Red")