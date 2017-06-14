/*The builder pattern is used to create complex objects with constituent parts that must be created in the same order or using a specific algorithm. An external class controls the construction algorithm.*/

//Example 1

class AndroidPhone {
    var osVersion: String!
    var name: String!
    var cpuCodeName: String!
    var RAMsize: Int!
    var osVersionCode: Double!
    var launcher: String!
}

protocol BPAndroidPhoneBuilder {
    var phone: AndroidPhone { get }
    
    func setOSVersion()
    func setName()
    func setCPUCodeName()
    func setRAMSize()
    func setOSVersionCode()
    func setLauncher()
}

//create Builder 1
class LowPricePhoneBuilder: BPAndroidPhoneBuilder {
    var phone = AndroidPhone()
    
    func setOSVersion() {
        phone.osVersion = "Android 2.3"
    }
    func setName() {
        phone.name = "Low price phone!"
    }
    func setCPUCodeName() {
        phone.cpuCodeName = "Some shitty CPU"
    }
    func setRAMSize() {
        phone.RAMsize = 256
    }
    func setOSVersionCode() {
        phone.osVersionCode = 3.0
    }
    func setLauncher() {
        phone.launcher = "Hia Tsung!"
    }
}

//create Builder 2
class HighPricePhoneBuilder: BPAndroidPhoneBuilder {
    var phone = AndroidPhone()
    func setOSVersion() {
        phone.osVersion = "Android 4.1"
    }
    func setName() {
        phone.name = "High price phone!"
    }
    func setCPUCodeName() {
        phone.cpuCodeName = "Some shitty but expensive CPU"
    }
    func setRAMSize() {
        phone.RAMsize = 1024
    }
    func setOSVersionCode() {
        phone.osVersionCode = 4.1
    }
    func setLauncher() {
        phone.launcher = "Samsung Launcher"
    }
}

class FactorySalesMan {
    private var builder: BPAndroidPhoneBuilder!
    
    var phone: AndroidPhone {
        return builder.phone
    }
    func setBuilder(builder: BPAndroidPhoneBuilder) {
        self.builder = builder
    }
    
    func constructPhone() {
        builder.setOSVersion()
        builder.setName()
        builder.setCPUCodeName()
        builder.setRAMSize()
        builder.setOSVersion()
        builder.setOSVersionCode()
        builder.setLauncher()
    }
}

let cheapPhoneBuilder = LowPricePhoneBuilder()
let expensivePhoneBuilder = HighPricePhoneBuilder()
let salesMan = FactorySalesMan()
salesMan.setBuilder(builder: cheapPhoneBuilder)
salesMan.constructPhone()
var phone = salesMan.phone
print("Phone Name = \(phone.name!), osVersion = \(phone.osVersion!), cpu code name = \(phone.cpuCodeName!), ram size = \(phone.RAMsize!), osversion code = \(phone.osVersionCode), launcher = \(phone.launcher!)")
salesMan.setBuilder(builder: expensivePhoneBuilder)
salesMan.constructPhone()
phone = salesMan.phone
print("Phone Name = \(phone.name!), osVersion = \(phone.osVersion!), cpu code name = \(phone.cpuCodeName!), ram size = \(phone.RAMsize!), osversion code = \(phone.osVersionCode), launcher = \(phone.launcher!)")

//Example 2
class DeathStarBuilder {
    
    var x: Double?
    var y: Double?
    var z: Double?
    
    typealias BuilderClosure = (DeathStarBuilder) -> ()
    
    init(buildClosure: BuilderClosure) {
        buildClosure(self)
    }
}

struct DeathStar : CustomStringConvertible {
    
    let x: Double
    let y: Double
    let z: Double
    
    init?(builder: DeathStarBuilder) {
        
        if let x = builder.x, let y = builder.y, let z = builder.z {
            self.x = x
            self.y = y
            self.z = z
        } else {
            return nil
        }
    }
    
    var description:String {
        return "Death Star at (x:\(x) y:\(y) z:\(z))"
    }
}

let empire = DeathStarBuilder { builder in
    builder.x = 0.1
    builder.y = 0.2
    builder.z = 0.3
}

let deathStar = DeathStar(builder:empire)
print(deathStar!)