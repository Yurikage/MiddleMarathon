/*The bridge pattern is used to separate the abstract elements of a class from the implementation details, providing the means to replace the implementation details without modifying the abstraction.*/

//Example 1
protocol BaseHeadphones {
    func playSimpleSound()
    func playBassSound()
}

class CheapHeadphones: BaseHeadphones {
    
    func playSimpleSound() {
        print("beep - beep - bhhhrhrhrep")
    }
    
    func playBassSound() {
        print("puf - puf - pufhrrr")
    }
    
}

class ExpensiveHeadphones: BaseHeadphones {
    
    func playSimpleSound() {
        print("Beep-Beep-Beep Taram - Rararam")
    }
    
    func playBassSound() {
        print("Bam-Bam-Bam")
    }
}

class MusicPlayer {
    
    var headPhones: BaseHeadphones!
    
    func playMusic() {
        headPhones.playBassSound()
        headPhones.playBassSound()
        headPhones.playSimpleSound()
        headPhones.playSimpleSound()
    }
    
}

let p = MusicPlayer()

let ch = CheapHeadphones()
let ep = ExpensiveHeadphones()

p.headPhones = ch
p.playMusic()

p.headPhones = ep
p.playMusic()

//Example 2

protocol Switch {
    var appliance: Appliance { get set }
    func turnOn()
}

protocol Appliance {
    func run()
}

class RemoteConrol: Switch {
    var appliance: Appliance
    
    func turnOn() {
        appliance.run()
    }
    
    init(appliance: Appliance) {
        self.appliance = appliance
    }
}

class TV: Appliance {
    
    func run() {
        print("tv turned on")
    }

}

class VacuumCleaner: Appliance {
    func run() {
        print("vacuum cleaner turned on")
    }
}

var tvRemotecontrol = RemoteConrol(appliance: TV())
tvRemotecontrol.turnOn()

var fancyVacuumCleanerRemoteControl = RemoteConrol(appliance: VacuumCleaner())
fancyVacuumCleanerRemoteControl.turnOn()