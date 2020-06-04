import UIKit

//функция, определяющая делится ли число на два
func isEven(numb: Int) -> Bool {
    if numb % 2 == 0 {return true} else {return false}
}

//функция, определяющая делится ли число на три
func isThreven(numb: Int) -> Bool {
    if numb % 3 == 0 {return true} else {return false}
}

//создаем массив чисел от 1 до 100
var arr: [Int] = []
for i in 1...100 {
    arr.append(i)
}

//удаляем все четные числа, и числа, делящиеся на три без остатка
for index in stride(from: arr.count-1, to: 0, by: -1) {
    if (isEven(numb: arr[index]) || isThreven(numb: arr[index])) {
        arr.remove(at: index)
    }
}

//функция добавления в массив числе Фибоначчи
func addFibonacciNumber(array arr: inout[Double]) -> Void {
    if arr.count>1 {
        arr.append(arr[arr.count-1]+arr[arr.count-2])
    }
}

//добавляем 100 элементов Фибоначчи
var arr2: [Double] = [1,2]
for _ in 1...100 {
    addFibonacciNumber(array: &arr2)
}

//функция создания массива простых чисел
func primeNumber(requiredPrimeNumbersCount count: Int) -> [Double] {
    var arrPrime: [Double] = [] //arr of prime numbers
    arrPrime.append(2.0)
    for i in 3...1000000 {
        arrPrime.append(Double(i))
        for j in 2...i-1 {
            if i % j == 0 {
                arrPrime.removeLast()
                break
            }
        }
        if arrPrime.count >= count {break}
    }
    return arrPrime
}

let primeNumsArray: [Double] = primeNumber(requiredPrimeNumbersCount: 30)
print(primeNumsArray)
