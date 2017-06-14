/*The singleton pattern ensures that only one object of a particular class is ever created. All further references to objects of the singleton class refer to the same underlying instance. There are very few applications, do not overuse this pattern!*/

//Example 1
class SingletonObject {
    private static let obj: SingletonObject = {
        return SingletonObject()
    }()
    
    class func singleton() -> SingletonObject {
        return obj
    }
    
    var tmpProperty: String!
}

SingletonObject.singleton().tmpProperty = "Hello 2 You"
print(SingletonObject.singleton().tmpProperty)

//Example 2

class DeathSuperlaser {
    static let sharedInstance = DeathSuperlaser()
    private init() {}
}

let laser = DeathSuperlaser.sharedInstance