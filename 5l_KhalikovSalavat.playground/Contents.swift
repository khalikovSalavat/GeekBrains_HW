import UIKit

protocol CarExecutable {
    var color: UIColor {get set}
    var year: Int {get set}
    var hp: Int {get set}
    var engineRuns: Bool {get set}
}

extension CarExecutable {
    mutating func startEngine() {
        guard !engineRuns else {
            print("Engine already runs")
            return
        }
        engineRuns = true
        print("Engine started")
    }
    
    mutating func stopEngine() {
        guard engineRuns else {
            print("Engine already stopped")
            return
        }
        engineRuns = false
        print("Engine stopped")
    }
}

enum SportCarInterior : String{
    case basic = "Basic interior"
    case leather = "Awesome leather"
    case wood = "Antient wood"
    case carbon = "Light & stylish carbon"
}

class SportCar: CarExecutable {
    var color: UIColor = .black
    var year: Int = 2015
    var hp: Int = 500
    var engineRuns: Bool = false
    var interior: SportCarInterior = .basic
    private var spoilerIsUp: Bool = false
    
    func liftSpoiler() {
        guard !spoilerIsUp else {
            print("Spoiler already lifted")
            return
        }
        spoilerIsUp = true
        print("Spoiler lifted up")
    }
    
    func pullDownSpoiler() {
        guard spoilerIsUp else {
            print("Spoiler already pulled down.")
            return
        }
        spoilerIsUp = false
        print("Spoiler is pulled down")
    }
}

extension SportCar: CustomStringConvertible {
    var description: String {
        return "SportCar info:\n Horse power: \(hp)\n Interior: \(interior)"
    }
}

var avenator = SportCar()
print("sport car Avenator")
avenator.liftSpoiler()
avenator.pullDownSpoiler()
print(avenator)
print(String(repeating: "=", count: 15))

class Trunk: CarExecutable {
    var color: UIColor = .black
    var year: Int = 2015
    var hp: Int = 500
    var engineRuns: Bool = false
    var trailerHooked: Bool = false
    
    func hookTrailer() {
        guard !trailerHooked else {
            print("Trailer already hooked!")
            return
        }
        trailerHooked = true
        print("Trailer hooked")
    }
    
    func unHookTrailer() {
        guard trailerHooked else {
            print("No trailer to unhook")
            return
        }
        trailerHooked = false
        print("Trailer unhooked")
    }
}

extension Trunk: CustomStringConvertible {
    var description: String {
        return "Trunk info:\n Color: \(color)\n Trailer is \(trailerHooked ? "" : "not") hooked"
    }
}

print("trunk Semi")
var semi = Trunk()
semi.hookTrailer()
print(semi)
semi.unHookTrailer()
semi.unHookTrailer()
print(semi)
