/*:The prototype pattern is used to instantiate a new object by copying all of the properties of an existing object, creating an independent clone. 
 This practise is particularly useful when the construction of a new object is inefficient.*/

// Example 1

protocol Copyring {
    init(instance: Self)
}

extension Copyring {
    func copy() -> Self {
        return Self.init(instance: self)
    }
}

class Person: Copyring {
    var name: String!
    var surname: String!
    
    init() {}
    
    required init(instance: Person) {
        name = instance.name
        surname = instance.surname
    }
}

let firstPerson = Person()
firstPerson.name = "Dima"
firstPerson.surname = "Backman"

let secondPerson = firstPerson.copy()
secondPerson.name = "Taras"
secondPerson.surname = "Bendug"

print("firstPerson:", firstPerson.name, " ", firstPerson.surname)
print("secondPerson:", secondPerson.name, " ", secondPerson.surname)

//Example 2 

class ChungasRevengeDisplay {
    var name: String?
    var font: String
    
    init(font: String) {
        self.font = font
    }
    
    func clone() -> ChungasRevengeDisplay {
        return ChungasRevengeDisplay(font: self.font)
    }
}

let Prototype = ChungasRevengeDisplay(font: "GotanProject")

let Philippe = Prototype.clone()
Philippe.name = "Philippe"

let Christoph = Prototype.clone()
Christoph.name = "Christoph"

print(Philippe.name!)
print(Christoph.name!)