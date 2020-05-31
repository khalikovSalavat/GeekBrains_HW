import UIKit


//task-1 Quadratic equation
var x: Double = 2
var y: Double = 2*pow(x, 2)+3*x
print("Задание-1")
print("Уравнение: f(x)=2x^2+3x")
print("Если x=2 то f(x)=" + String(y))

//task-2 Tight triangle
var cat1: Double = 3
var cat2: Double = 4
var s: Double = cat1*cat2/2
var hypo: Double = sqrt(pow(cat1, 2) + pow(cat2,2))
var p: Double = cat1+cat2+hypo
print("")
print("Задание-2")
print("Катет-1: " + String(cat1) + ", Катет-2: " + String(cat2))
print("Тогда Гипотенуза: " + String(hypo) + ", Площадь треугольника: " + String(s) + " Периметр треугольника: " + String(p))

//task-3 Bank
print("")
print("Задание-3")
//НЕ ПОЛУЧИЛОСЬ ПОЛУЧИТЬ ДАННЫЕ ЧЕРЕЗ READLINE()
//var input: String? = readLine()
//var deposit: Double? = Double(input ?? "0")
//input = readLine()
var deposit: Double = 1000000
var perc: Double = 6
var sum: Double = deposit
for i in 1...5 {
    sum = sum + sum * perc/100
}
print("Вклад: " + String(deposit) + ", Годовой процент: " + String(perc))
print("Сумма вклада через 5 лет составит: " + String(sum))
