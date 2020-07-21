//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport


let wiseWords = "\"Image is a message\" -zxd"
print(wiseWords)

let dollarSign = "\u{24}"
print(dollarSign, terminator: "")
let sparklingHeart = "\u{1F496}"
print(sparklingHeart,terminator: "\n")

let threeDouble = """
"asdasd"
"""
print(threeDouble,terminator: "\n")

let extendString = #"Line 1\#nLine 2"#
print(extendString)
for a in wiseWords {
    print(a)
}

var catString = String(["C", "a", "t", "!", "🐱️"])
print(catString)

catString.append(wiseWords)
print(catString)
var a = "a"

let decomposed: Character = "\u{1112}\u{1161}\u{11AB}"
print(decomposed)
print("\u{1112}")

let enclosedEAcute: Character = "\u{1112}\u{1161}\u{11AB}\u{20DD}"
print(enclosedEAcute)

var word = "cafe"
print("the number of characters in \(word) is \(word.count)")

word.append("\u{301}")

print("the number of characters in \(word) is \(word.count)")

var greeting = "Guten Tag!"

greeting[greeting.startIndex]
greeting[greeting.index(before: greeting.endIndex)]
greeting[greeting.index(after: greeting.startIndex)]
let index = greeting.index(greeting.startIndex, offsetBy: 6)
print(greeting[index])


var welcome = "hello"

welcome.insert("!", at: welcome.endIndex)
welcome.insert(contentsOf: " there", at: welcome.index(before: welcome.endIndex))
print(welcome.remove(at: welcome.index(before: welcome.endIndex)))
print(welcome)
let range = welcome.index(welcome.endIndex,offsetBy: -6)..<welcome.endIndex
print(welcome.removeSubrange(range))
print(welcome)

greeting = "Hello, world!"
var indexx = greeting.firstIndex(of: ",") ?? greeting.endIndex
var beginning = greeting[..<indexx]
beginning += "b"
print(greeting)

let eAcuteQuestion = "Voulez-vous un caf\u{E9}?"
let combinedEAcuteQuestion = "Voulez-vous un caf\u{65}\u{301}?"
if eAcuteQuestion == combinedEAcuteQuestion {
    print("they are equal")
}
