import UIKit

enum SuperCarAction {
    case startEngine, stopEngine
    case loadBaggage (Int)
    case unLoadBaggage (Int)
}

class Car {
    var color: UIColor = .black
    var year: Int = 1990
    var hp: Int = 90
    internal var engineRuns: Bool = false
    var trunkVol: Int = 400 //
    internal var usedTrunkVol: Int = 0 // КАК МОЖНО ДЕАКТИВИРОВАТЬ ЭТО ПОЛЕ И ПОЛЕ ВЫШЕ В НАСЛЕДУЕМОМ КЛАССЕ? К ПРИМЕРУ В КЛАССЕ ГРУЗОВИК БАГАЖНИКА НЕ БУДЕТ/
}

enum SportCarInterior : String{
    case basic = "Basic interior"
    case leather = "Awesome leather"
    case wood = "Antient wood"
    case carbon = "Light & stylish carbon"
}

enum SportCarModels {
    case _911, P1, agera
}

class sportCar: Car {
    var interior: SportCarInterior = .basic
    var spoiler: Bool = true
    var carbonWheels: Bool = false
    private var nitro: Bool = false
    var acceleration: Double {
        get {
            return Double(hp) / 150
        }
    }
    
    func installNitro() {
        if nitro {
            print("Nitro already has installed")
        } else{
            nitro = true
            print("Nitro installation success!")
        }
    }
    
    private var engineStage: Int = 0
    func powerUpEngine() {
        if engineStage == 3 {
            print("Engine's MAX stage, sorry.")
        } else {
            hp += 100
            engineStage += 1
            print("Engine upgrated.\nHP: \(hp)\nAcceleration: \(String(format: "%.2f", acceleration))\nStage: \(engineStage)")
        }
    }
    
    func action (action: SuperCarAction) {
        switch action {
        case .startEngine:
            if engineRuns {print("Engine is already running")} else {
            engineRuns = true
            print("Engine is turned on")
            }
        case .stopEngine:
            if !engineRuns {print("Engine already stopped")} else {
                engineRuns = false
                print("Engine is stopped")
            }
        case let .loadBaggage(baggage):
            if usedTrunkVol + baggage > trunkVol {
                print("Can't load new baggage, not enough free space")
            } else {
                usedTrunkVol += baggage
                print("Baggage loaded. Used volume: \(usedTrunkVol) from: \(trunkVol)")
            }
        case let .unLoadBaggage(baggage):
            if baggage > usedTrunkVol {
                print("Please select correct weight of baggage. Current baggage volums is \(usedTrunkVol)")
            } else {
                usedTrunkVol -= baggage
                print("Baggage unload. Used volume: \(usedTrunkVol) from \(trunkVol)")
            }
        }
    }
    
    init(sportCarModel: SportCarModels) {
        super.init()
        switch sportCarModel{
        case ._911:
            self.color = .red
            self.year = 2020
            self.hp = 700
            self.interior = .leather
            self.trunkVol = 150
        case .agera:
            self.color = .gray
            self.year = 2016
            self.hp = 900
            self.interior = .carbon
            self.trunkVol = 50
        case .P1:
            self.color = .cyan
            self.year = 2014
            self.hp = 900
            self.interior = .wood
            self.trunkVol = 50
        }
    }
    
    init(color: UIColor, year: Int, hp: Int, interior: SportCarInterior) {
        super.init()
        self.color = color
        self.year = year
        self.hp = hp
        self.interior = interior
    }
    
    func printInfo(){
        print("SportCar:\nColor: \(color)\nManufacture year: \(year)\nHorse power: \(hp)\nAcceleration: \(String(format: "%.2f", acceleration))\nInterior: \(interior.rawValue), trunk volume: \(trunkVol)")
    }
}

var agera = sportCar(sportCarModel: .agera)
agera.powerUpEngine()
agera.printInfo()

var _911 = sportCar(sportCarModel: ._911)
print("\n911")
_911.installNitro()
_911.printInfo()

print("\n\(String(repeating: "=", count: 50))\n")

enum TrunkActions {
    case startEngine, stopEngine
    case hookTrailer (Int)
    case unhookTrailer
}

class Trunk : Car {
    var trailerWeight: Int = 0
    var maxTrailerWeight: Int {
        get {
            return Int(Double(hp)*10)
        }
    }
    
    init(color: UIColor, year: Int, hp: Int) {
        super.init()
        trunkVol = 0
        self.color = color
        self.year = year
        self.hp = hp
    }
    
    func action (action: TrunkActions) {
        switch action {
        case .startEngine:
            if engineRuns {
                print("Engine already running")
            } else {
                engineRuns = true
                print("Engine started")
            }
        case .stopEngine:
            if !engineRuns {
                print("Engine already stopped")
            } else {
                engineRuns = false
                print("Engine stopped")
            }
        case let .hookTrailer(weight):
            if weight > maxTrailerWeight {
                print("Trailer *\(weight)* is too heavy. Max weight: \(maxTrailerWeight)")
            } else {
                trailerWeight = weight
                print("Trailer hook success. Weight: \(trailerWeight)")
            }
        case .unhookTrailer:
            if trailerWeight == 0 {
                print("No trailer to unhook")
            } else {
                trailerWeight = 0
                print("Trailer unhooked")
            }
        }
    }
    
    func printInfo() {
        print("Trunk:\nColor: \(color)\nManufacture year: \(year)\nHorse power: \(hp)\nTrailer: \(trailerWeight)")
    }
}

var semi = Trunk(color: .gray, year: 2019, hp: 1000)
semi.action(action: .hookTrailer(100))
semi.action(action: .unhookTrailer)
semi.printInfo()
