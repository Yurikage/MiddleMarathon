/*The mediator pattern is used to reduce coupling between classes that communicate with each other. Instead of classes communicating directly, and thus requiring knowledge of their implementation, the classes send messages via a mediator object.*/

//Example 1

class SmartHousePart {
    private unowned var processor: CentrallProcessor
    
    init(processor: CentrallProcessor) {
        self.processor = processor
    }
    
    func numbersChanged() {
        processor.valueChanged(part: self)
    }
}

class CentrallProcessor {
    var thermometer: Thermometer!
    var condSystem: ConditioningSystem!
    
    func valueChanged(part: SmartHousePart) {
        print("Value changed! We need to do smth!")
        if part is Thermometer {
            condSystem.startCondition()
        }
    }
}

class Thermometer: SmartHousePart {
    private var temperature: Int!
    func temperatureChanged(temperature: Int) {
        self.temperature = temperature
        numbersChanged()
    }
}

class ConditioningSystem: SmartHousePart {
    func startCondition() {
        print("Conditioning...")
    }
}

let processor = CentrallProcessor()
let therm = Thermometer(processor: processor)
let condSystem = ConditioningSystem(processor: processor)

processor.condSystem = condSystem
processor.thermometer = therm

therm.temperatureChanged(temperature: 4)

//Example 2
struct Programmer {
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    func receive(message: String) {
        print("\(name) received: \(message)")
    }
}

protocol MessageSending {
    func send(message: String)
}

final class MessageMediator: MessageSending {
    private var recipients: [Programmer] = []
    
    func add(recipient: Programmer) {
        recipients.append(recipient)
    }
    
    func send(message: String) {
        for recipient in recipients {
            recipient.receive(message: message)
        }
    }
}

func spamMonster(message: String, worker: MessageSending) {
    worker.send(message: message)
}

let messageMediator = MessageMediator()

let user0 = Programmer(name: "Linus Torvalds")
let user1 = Programmer(name: "Avadis 'Avie' Tevanian")
messageMediator.add(recipient: user0)
messageMediator.add(recipient: user1)

spamMonster(message: "I'd Like to Add you to My Professional Network", worker: messageMediator)
