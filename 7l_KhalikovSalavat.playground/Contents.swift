import UIKit

//1. Придумать класс, методы которого могут создавать непоправимые ошибки. Реализовать их с помощью try/catch.
//2. Придумать класс, методы которого могут завершаться неудачей. Реализовать их с использованием Error.

struct Product {
    var name: String
}

enum ShelfErrors: Error {
    case invalidSelection
    case outOfStock
    case insufficientFunds (coinsNeeded: Int)
}

struct Item : CustomStringConvertible{
    var price: Int
    var count: Int
    let product: Product
    var description: String {
        return "\(product):$\(price):\(count)"
        
    }
    
}

class FoodShelf {
    var inventory = [
        "Bread" : Item (price: 30, count: 10, product: Product(name: "Bread")),
        "Baton" : Item (price: 25, count: 5, product: Product(name: "Baton")),
        "Croissant": Item (price: 15, count: 25, product: Product(name: "Croissant"))
    ]
    
    var coinsDeposited: Int = 0

    func vend (name: String) -> (Item?, ShelfErrors?) {
        guard let item = inventory[name] else {
            return (nil, .invalidSelection)
        }
        guard item.count > 0 else {
            return (nil, .outOfStock)
        }
        guard coinsDeposited >= item.price else {
            return (nil, .insufficientFunds(coinsNeeded: item.price - coinsDeposited))
        }
        inventory[name]?.count -= 1
        coinsDeposited -= item.price
        print("Dispensing \(item.product.name)...")
        return (item, nil)
    }
}

var foodShelf = FoodShelf()
print(foodShelf.inventory)
foodShelf.coinsDeposited = 200
let sell1 = foodShelf.vend(name: "Bread")
let sell2 = foodShelf.vend(name: "Sneakers")

if let product = sell1.0 {
    print("You bought \(product.product.name)")
} else if let error = sell1.1 {
    print(error.localizedDescription)
}

if let product = sell2.0 {
    print("You bought \(product.product.name)")
} else if let error = sell2.1 {
    print(error.localizedDescription)
}
print(String(repeating: "=", count: 20))
print("\n")

//СОЗДАЕМ АНАЛОГИЧНЫЙ С ПРЕДЫДУЩИМ КЛАСС
class SnacksShelf {
    var inventory = [
        "Sneakers" : Item(price: 50, count: 20, product: Product(name: "Sneakers")),
        "Nuts" : Item(price: 50, count: 20, product: Product(name: "Nuts")),
        "KitKat" : Item(price: 50, count: 20, product: Product(name: "KitKat")),
    ]
    
    var coinsDeposited: Int = 0
    
    func vend(itemNamed name: String) throws -> Item {
        guard let item = inventory[name] else {
            throw ShelfErrors.invalidSelection
        }
        
        guard item.count > 0 else {
            throw ShelfErrors.outOfStock
        }
        
        guard item.price > coinsDeposited else {
            throw ShelfErrors.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }
        inventory[name]?.count -= 1
        print("Item \(item.product.name) successfully bought")
        return item
    }
}

let snackShelf = SnacksShelf()

do {
    try snackShelf.vend(itemNamed: "Sneakers")
} catch ShelfErrors.invalidSelection {
    print("Please choose existing item")
} catch ShelfErrors.outOfStock {
    print("This item is no longer avaliable")
} catch ShelfErrors.insufficientFunds(let coinsNeeded) {
    print("\(coinsNeeded) required")
} catch {
    print("Other error")
}
