//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport


let numberOfLegs = ["spider":8,"ant":6,"cat":4]
for item in numberOfLegs {
    print(item.key)
}

for index in 1...5{
    print(index)
}

let base = 3
let power = 10
var answer = 1
for _ in 1...power {
    answer *= base
}
print(answer)

let minutes = 60
for tickMark in 0..<minutes {
    print(tickMark)
}

// stride(from:to:by:)
for tickMark in stride(from: 0, to: minutes, by: 5) {
    print(tickMark)
}

// stride(from:through:by:)
for tickMark in stride(from: 0, through: minutes, by: 5) {
    print(tickMark)
}

//while

let finalSquare = 25
var board = [Int](repeating: 0, count: finalSquare+1)
board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08

var square = 0
var diceRoll = 0
while square < finalSquare {
    //roll the dice
    diceRoll += 1
    if diceRoll == 7 { diceRoll = 1}
    square += diceRoll
    if square < board.count {
        square += board[square]
    }
}
square = 0
diceRoll = 0
repeat {
    square += board[square]
    diceRoll += 1
    if diceRoll == 7 {diceRoll = 1}
    square += diceRoll
} while square < finalSquare

//switch
//一个case匹配多种情况
let another:Character = "A"
switch another {
case "a","A":
    print(another)
default:
    print("nothing")
}

//区间匹配
let approximateCount = 10
switch approximateCount {
case 1...5:
    print("1-5:\(approximateCount)")
case 6..<10:
    print("6..<10:\(approximateCount)")
case 10..<100:
    print("10..<100:\(approximateCount)")
default:
    print("null")
}

//元组
let somePoint = (-2,2)
switch somePoint {
case (0,0):
    print("(0, 0) is at the origin")
case (_,0):
    print("(\(somePoint.0), 0) is on the x-axis")
case (0,_):
    print("(0,\(somePoint.1)) is on the y-axis")
case (-2...2,-2...2):
    print("(\(somePoint.0),\(somePoint.1)) is in the box")
default:
    print("(\(somePoint.0),\(somePoint.1)) is out the box")
}

//值绑定
let anotherPoint = (1,0)
switch anotherPoint {
case (let x,0):
    print("(\(x), 0) is on the x-axis")
case (0,let y):
    print("(0,\(y)) is on the y-axis")
case let (x,y):
    print("(\(x),\(y)) is in the box")
}

//guard
func greet(person:[String:String]){//字典
    guard let name = person["name"] else {
        return
    }
    
    print("Hello \(name)!")
    
    guard let location = person["location"] else {
        print("I hope the weather is nice near you.")
        return
    }
    print("I hope the weather is nice in \(location).")
}
greet(person: ["name": "John"])
greet(person: ["name": "Jane", "location": "Cupertino"])
