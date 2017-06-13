/*The abstract factory pattern is used to provide a client with a set of related or dependant objects. The "family" of objects created by the factory are determined at run-time.*/

//Example 1

protocol GenericIPad {
    var osName: String { get }
    var productName: String { get }
    var screenSize: Double { get }
}

protocol GenericIPhone {
    var osName: String { get }
    var productName: String { get }
}

protocol IPhoneFactory {
    func getIPhone() -> GenericIPhone
    func getIPad() -> GenericIPad
}

class AppleIPhone: GenericIPhone {
    var osName = "iOS"
    var productName = "iPhone"
}

class AppleIPad: GenericIPad {
    var osName = "iOS"
    var productName = "iPad"
    var screenSize = 7.7
}

class ChinaPhone: GenericIPhone {
    var osName = "Android"
    var productName = "Chi Huan Hua Phone"
}

class ChinaPad: GenericIPad {
    var osName = "Windows CE"
    var productName = "Buan Que Ipado Killa"
    var screenSize = 12.5
}

class AppleFactory: IPhoneFactory {
    func getIPhone() -> GenericIPhone {
        return AppleIPhone()
    }
    
    func getIPad() -> GenericIPad {
        return AppleIPad()
    }
}

class ChinaFactory: IPhoneFactory {
    func getIPhone() -> GenericIPhone {
        return ChinaPhone()
    }
    
    func getIPad() -> GenericIPad {
        return ChinaPad()
    }
}

var isThirdWorld = true

func getFactory() -> IPhoneFactory {
    return isThirdWorld ? AppleFactory() : ChinaFactory()
}

isThirdWorld = false

let factory = getFactory()
let ipad = factory.getIPad()
let iphone = factory.getIPhone()

print("IPad named = \(ipad.productName), osname = \(ipad.osName),screensize = \(ipad.screenSize)")
    print("IPhone named = \(iphone.productName), osname = \(iphone.osName)")

//Example 2
import Foundation

//Protocols
protocol Decimal {
    func stringValue() -> String
    //factory
    static func make(string: String) -> Decimal
}

typealias NumberFactory = (String) -> Decimal

struct NextStepNumber: Decimal {
    private var nextStepNumber: NSNumber
    
    func stringValue() -> String { return nextStepNumber.stringValue }
    
    static func make(string: String) -> Decimal {
        return NextStepNumber(nextStepNumber: NSNumber(value: (string as NSString).longLongValue ))
    }
}

struct SwiftNumber: Decimal {
    private var swiftInt: Int
    
    func stringValue() -> String { return "\(swiftInt)" }
    
    static func make(string: String) -> Decimal {
        return SwiftNumber(swiftInt: (string as NSString).integerValue)
    }
}

//Abstract factory

enum NumberType {
    case nextStep, swift
}

enum NumberHelper {
    static func factory(for type: NumberType) -> NumberFactory {
        switch type {
        case .nextStep:
            return NextStepNumber.make
        case .swift:
            return SwiftNumber.make
        }
    }
}

//Usage

let factoryOne = NumberHelper.factory(for: .nextStep)
let numberOne = factoryOne("1")
print(numberOne.stringValue())

let factoryTwo = NumberHelper.factory(for: .swift)
let numberTwo = factoryTwo("2")
print(numberTwo.stringValue())