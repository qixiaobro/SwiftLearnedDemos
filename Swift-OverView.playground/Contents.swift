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
