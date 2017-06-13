/*The factory pattern is used to replace class constructors, abstracting the process of object generation so that the type of the object instantiated can be determined at run-time.*/

//Example 1

protocol Product {
    var price: Int { get }
    var name: String { get }
    
    func getTotalPrice(sum: Int) -> Int
    func saveObject()
}

extension Product {
    func getTotalPrice(sum: Int) -> Int {
        return price + sum
    }
}

class Toy: Product {
    var price = 50
    var name = "Toy"
    
    func saveObject() {
        print("Saving objet into Toys database")
    }
}

class Dress: Product {
    var price = 150
    var name = "Dress"
    
    func saveObject() {
        print("Saving object into Dress database")
    }
}

class ProductGenerator {
    func getProduct(price: Int) -> Product? {
        switch price {
        case 0..<100:
            return Toy()
        case 100..<Int.max:
            return Dress()
        default:
            return nil
        }
    }
}

func saveExpenses(price: Int) {
    let pd = ProductGenerator()
    let expense = pd.getProduct(price: price)
    expense?.saveObject()
}

saveExpenses(price: 50)
saveExpenses(price: 56)
saveExpenses(price: 79)
saveExpenses(price: 100)
saveExpenses(price: 123)
saveExpenses(price: 51)

//example 2

protocol Currency {
    func symbol() -> String
    func code() -> String
}

class Euro: Currency {
    func symbol() -> String {
        return "€"
    }
    
    func code() -> String {
        return "EUR"
    }
}

class UnitedStatesDolar: Currency {
    func symbol() -> String {
        return "$"
    }
    
    func code() -> String {
        return "USD"
    }
}

enum Country {
    case unitedStates, spain, uk, greece
}

enum CurrencyFactory {
    static func currency(for country: Country) -> Currency? {
        switch country {
        case .spain, .greece, .uk:
            return Euro()
        case .unitedStates :
            return UnitedStatesDolar()
        default:
            return nil
        }
    }
}

let noCurrencyCode = "No Currency Code Available"

print(CurrencyFactory.currency(for: .greece)?.code() ?? noCurrencyCode)
print(CurrencyFactory.currency(for: .spain)?.code() ?? noCurrencyCode)
print(CurrencyFactory.currency(for: .unitedStates)?.code() ?? noCurrencyCode)
print(CurrencyFactory.currency(for: .uk)?.code() ?? noCurrencyCode)