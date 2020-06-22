import UIKit

//1. Реализовать свой тип коллекции «очередь» (queue) c использованием дженериков.
//2. Добавить ему несколько методов высшего порядка, полезных для этой коллекции (пример: filter для массивов)
//3. * Добавить свой subscript, который будет возвращать nil в случае обращения к несуществующему индексу.

protocol Personalizible {
    var name: String { get set }
    var sex: Sex { get set }
    var age: Int { get }
}

enum Sex {case male, female}

class Person: CustomStringConvertible, Personalizible {

    var name: String
    var sex: Sex = .male
    let age: Int
    static var randomSex: Sex {
        if Bool.random() { return .male } else { return .female}
    }
    
    init(_ name: String, _ sex: Sex) {
        self.name = name
        self.sex = sex
        self.age = Int.random(in: 15...80)
    }
    
    init (_ name: String, _ sex: Sex, _ age: Int) {
        self.name = name
        self.sex = sex
        self.age = age
    }
    
    var description: String {
        return "\(name):\(age), \(sex)"
    }
}

struct Queue<T: Personalizible> {
    private var arr: [T] = []
    
    mutating func enqueue (_ delegate: T ...) {
        for d in delegate { arr.append(d) }
    }
    
    mutating func dequeue() -> T { return arr.removeFirst() }
    
    mutating func filterBySex (sex: Sex, predicate: (Sex, T) -> Bool) -> [T] {
        var tempArr: [T] = []
        for d in self.arr {
            if predicate(sex, d) {
                tempArr.append(d)
            }
        }
        return tempArr
    }
    
    mutating func filterByAge (minAge: Int, maxAge: Int) -> [T] {
        return arr.filter{($0.age >= minAge) && ($0.age <= maxAge)}
    }
    
    mutating func sortByAge (ascending: Bool) -> [T] {
        if ascending {
            return arr.sorted { $0.age < $1.age}
        } else {
            return arr.sorted { $0.age > $1.age }
        }
    }
    
    subscript (indexes: Int ...) -> String? {
        var maleCount: Int = 0
        var femaleCount: Int = 0
        for i in indexes {
            guard i < arr.count else {
                return nil
            }
            if arr[i].sex == .male {
                maleCount += 1
            } else {
                femaleCount += 1
            }
        }
        return "Queue | males: \(maleCount), females: \(femaleCount)"
    }
    
}

var shopQueue = Queue<Person>()
shopQueue.enqueue(Person("Vasya", .male), Person("Igor", .male), Person("Veronika", .female), Person("Arnold", .male), Person("Katy", .female))
print("\(shopQueue.dequeue()) is in the shop")

print(shopQueue)

var sexClosure: (Sex, Personalizible) -> Bool = {(sex: Sex, p: Personalizible) -> Bool in
    if p.sex == sex {
        return true
    } else {
        return false
    }
}

var filteredQueue = shopQueue.filterBySex(sex: .female, predicate: sexClosure)

print(shopQueue[0,2,3] ?? "nil returning")

print(shopQueue.filterByAge(minAge: 50, maxAge: 70))

print(shopQueue.sortByAge(ascending: false))

var numbersArray = Array(1...20)
let newQueue = numbersArray.map({ (element: Int) -> Person in
    return Person("No name", Person.randomSex, element)
})
print(newQueue)


//КОД НИЖЕ ВЫДАЕТ ОШИБКУ. МОЖНО ПОДСКАЗАТЬ ПОЧЕМУ И КАК СДЕЛАТЬ ПРАВИЛЬНО?
//class test {
//    var a: Int = 0
//    private var closureVar: String = { (_ a.self: Int) -> String in
//        return "a: \(self.a)"}
//
//
//    deinit {
//        print("test class instance deleted")
//    }
//}
