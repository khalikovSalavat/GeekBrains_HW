import UIKit

enum PassengerCarBrands {
    case vw, hyundai, kia, reno
}

enum CarModels {
    case polo
    case solaris
    case rio
}

enum CarActions {
    case startStopEngine
    case openCloseWindow
}

struct PassengerCar {
    let brand: PassengerCarBrands
    let yearOfManufacture: UInt
    var engineOn: Bool
    var WindowClosed: Bool
    
    init(brand: PassengerCarBrands, yearOfManufacture: UInt, engineOn: Bool, WindowsClosed: Bool) {
        self.brand = brand
        self.yearOfManufacture = yearOfManufacture
        self.engineOn = engineOn
        self.WindowClosed = WindowsClosed
    }
    
    init(carModel: CarModels) {
        switch carModel {
        case .polo:
            self.brand = PassengerCarBrands.vw
            self.yearOfManufacture = 2012
            self.engineOn = true
            self.WindowClosed = true
        case .rio:
            self.brand = PassengerCarBrands.kia
            self.yearOfManufacture = 2013
            self.engineOn = true
            self.WindowClosed = true
        case .solaris:
            self.brand = PassengerCarBrands.vw
            self.yearOfManufacture = 2010
            self.engineOn = true
            self.WindowClosed = true
        }
    }
    
    mutating func carAction (action : CarActions) {
        switch action {
        case .startStopEngine:
            self.engineOn = !self.engineOn
            print("Engine is \(self.engineOn ? "On" : "Off")")
        case .openCloseWindow:
            self.WindowClosed = !self.WindowClosed
            print("Windows are \(self.WindowClosed ? "opened" : "closed")")
        }
    }
}

enum TruckBrands {
    case volvo, tesla, man, mersedes
}

enum TruckActions {
    case startStopEngine
    case attachUnhookTrailer (TrailerActions)
}

enum TrailerActions {
    case attach (Double)
    case unhook (Bool)
    case reAttach (Double)
}

struct Truck {
    let brand: TruckBrands
    let hp: UInt
    var engineOn: Bool
    var trailerWeight: Double = 0.0 {
        willSet {
            print("You're going to attach new trailer.")
        }
    }
    var truckLoad: Double {//грузоподъемность
        get {
            return Double(hp) * 50.0
        }
    }
    mutating func truckActions (action: TruckActions) {
        switch action {
        case .startStopEngine:
            self.engineOn = !self.engineOn
            print("Engin is: \(self.engineOn ? "On" : "Off")")
        case .attachUnhookTrailer(TrailerActions: .attach(let attach)):
            if attach > self.truckLoad {
                print("Can't take this trailer. Too much weight")
            } else {
                self.trailerWeight = attach
                print("Trailer attach success. New weight: \(self.trailerWeight)")
            }
        case .attachUnhookTrailer(TrailerActions: .unhook(let _)): //без let не работает, а зачем он нужен не понимаю
            if self.trailerWeight > 0 {
                self.trailerWeight = 0
                print("Trailer has been unhooked.")
            } else {
                print("Nothig to unhook")
            }
        case .attachUnhookTrailer(TrailerActions: .reAttach(let attach)):
            if attach > self.truckLoad {
                print("Can't take this trialer. Too much weight")
            } else {
                self.trailerWeight = attach
                print("Previous trailer has been unhooked.")
                print("Trailer attach success. New weight: \(self.trailerWeight)")
            }
        }
    }
}

var polo = PassengerCar(carModel: CarModels.polo)
var rio = PassengerCar(brand: PassengerCarBrands.kia, yearOfManufacture: 2013, engineOn: true, WindowsClosed: true)
polo.carAction(action: CarActions.startStopEngine)
rio.carAction(action: CarActions.openCloseWindow)
print(polo)
print(rio)
print("==================")

var semi = Truck(brand: TruckBrands.tesla, hp: 2000, engineOn: true)
semi.truckActions(action: .startStopEngine)
semi.truckActions(action: .attachUnhookTrailer(TrailerActions.attach(100000)))
semi.truckActions(action: .attachUnhookTrailer(TrailerActions.reAttach(200000)))
semi.truckActions(action: .attachUnhookTrailer(TrailerActions.unhook(true)))
print(semi)
