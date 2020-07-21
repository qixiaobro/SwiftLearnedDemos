//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport


let a:Float = 1.1
let b:Float = 2.3
let c = "c = \(a + b)"

let apples: Int = 3
let oranges: Int = 5
let quotation = """
I said "I have \(apples) apples."
And then I said "I have \(apples + oranges) pieces of fruit."
"""

let goods:Array = ["apple","banner"]
goods[1]

let occupation = [
    "a": "a",
    "b": "b"
]
occupation["b"]

var emptyArray = [String]()
var emptyDictionary = [String: Float]()

emptyArray = []
emptyDictionary = [:]

var optionalString: String? = nil
print(optionalString == nil)

var optionalName: String? = nil
var greeting = "Hello!"
if let name = optionalName {
    greeting = "Hello, \(name)"
}else {
    greeting = "wtf"
}

let nickName: String? = nil
let fullName: String = "zhuxiaodong"
let informalGreeting = "Hi, \(nickName ?? fullName)"

let vegetable = "red pepper"
switch vegetable {
case "celery":
    print("Add some raisins and make ants on a log.")
case "cucumber", "watercress":
    print("That would make a good tea sandwich.")
case let x where x.hasSuffix("pepper"):
    print("Is it a spicy \(x)?")
default:
    print("Everything tastes good in soup.")
}
//"Is it a spicy red pepper?"

let interestingNumbers = [
    "Prime": [2, 3, 5, 7, 11, 13],
    "Fibonacci": [1, 1, 2, 3, 5, 8],
    "Square": [1, 4, 9, 16, 25],
]
var largest = 0
var largestType: String = ""
for (kind, numbers) in interestingNumbers {
    for number in numbers {
        if number > largest {
            largest = number
            largestType = kind
        }
    }
}
print(largest,largestType)

var n = 2
while n < 100 {
    n *= 2
}
print(n)

var m = 2
repeat {
    m *= 2
} while m < 100

//函数

func greet(tes person: String, _ day: String) ->String {
    "Hello\(person),today is \(day)"
}

greet(tes: "zxd","2020")

func calucal(scores: [Int]) -> (min: Int, max: Int, sum: Int){
    var min = scores[0]
    var max = scores[0]
    var sum = 0
    
    for score in scores{
        if score > max{
            max = score
        }else if score < min {
            min = score
        }
        sum += score
    }
    return (min, max, sum)
}
print(calucal(scores: [1,2,44,5,66,67,23]).1)

func sumOf(numbers: Int...) ->Int{
    var sum: Int = 0
    for number in numbers {
        sum += number
    }
    return sum
}

sumOf()
sumOf(numbers: 42,34,121,44)

func makeIncrement() -> ((Int) -> Int){
    func addOne(number: Int) -> Int {
        return number + 1
    }
    return addOne
}

func hasAnyMatches(list: Int..., condition: (Int) -> Bool) -> Bool{
    for item in list {
        if condition(item) {
            return true
        }
    }
    return false
}

func lessThanTen(number: Int) -> Bool{
    return number < 10
}


hasAnyMatches(list: 12,12,14,15,16, condition: lessThanTen)

var numbers = [20,19,2,6]
let threeNumber = numbers.map{
    (number: Int) -> Int in
    let result = 3 * number
    return result
}
print(threeNumber)
let mapNumbers = numbers.map({number in 3 * number})
print(mapNumbers)
let sortedNumbers = numbers.sorted{$1 > $0}
print(sortedNumbers)


func hasAnyMatches2(list: Int..., condition: (Int) -> Bool) -> Bool{
    for item in list {
        if condition(item) {
            return true
        }
    }
    return false
}
let result = hasAnyMatches2(list: 12,12,14,15,16){number in number < 10}
print(result)

class Shape{
    var numberOfSides = 0
    func simpleDescription() -> String{
        return "a"
    }
}

let newShape = Shape()
print(newShape.simpleDescription())

class NamedShape{
    var numberOfSides: Int = 0
    var name: String
    
    init(name: String,b:Int){
        self.name = name
        numberOfSides = b
    }
    
    func simleDescription() -> String {
        return "\(numberOfSides)"
    }
}
let newNamedShape = NamedShape(name: "a", b: 2)
newNamedShape.simleDescription()

class Square: NamedShape{
    var sideLength: Double
    
    init(sideLength:Double,name:String) {
        self.sideLength = sideLength
        super.init(name: name, b: 4)
        numberOfSides = 5
    }
    
    func area() -> Double {
        return sideLength * sideLength
    }
    
    override func simleDescription() -> String {
        return "A square with sides of length \(sideLength)."
    }
}

let test = Square(sideLength: 2.2, name: "my test")
test.area()
test.simleDescription()
test.numberOfSides

class Circle: Square{
    var circleR:Double
    
    init(circleR:Double) {
        self.circleR = circleR
        super.init(sideLength: circleR, name: "my circle")
    }
    
    override func area() -> Double {
        return circleR * circleR * 3.14
    }
    
    override func simleDescription() -> String {
        return "my circe"
    }
}
let circle = Circle(circleR: 2.2)
print(circle.area())


protocol ExampleProtocol{
    var simpleDescription: String {get}
    mutating func adjust()
}

class SimpleClass: ExampleProtocol{
    var simpleDescription: String = "A very simple class"
    var anotherProperty: Int = 69105
    func adjust() {
        simpleDescription += "new 100% adjusted"
    }
}

var aSimpleClass = SimpleClass()
aSimpleClass.adjust()
let aDescription = aSimpleClass.simpleDescription

enum PrinterError: Error {
    case outOfPaper
    case noToner
    case onFire
}

func send(job: Int,toPrinter printerName:String) throws -> String{
    if printerName == "Never Has Toner" {
        throw PrinterError.noToner
    }
    return "job sent"
}

do {
    let printerResponse = try send(job: 1040, toPrinter: "Never Has Toner")
    print(printerResponse)
} catch {
    print(error)
}

let printerSuccess = try? send(job: 1040, toPrinter:    "Never sHas Toner")

var fridgeIsOpen = false;
let fridgeContent = ["milk","eggs","leftovers"]

func fridgeContains(_ food: String) -> Bool{
    fridgeIsOpen = true
    defer {
        fridgeIsOpen = false
    }
    let result = fridgeContent.contains(food)
    return result
}

fridgeContains("milk")
print(fridgeIsOpen)
