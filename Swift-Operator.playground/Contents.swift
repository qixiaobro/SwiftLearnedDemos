//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

let minusSix = -6

let alsoMinusSix = +minusSix

(3,"bird")>(2,"bird")

let defaultColor = "red"
var optionColor: String? = "blue"
let realColor = optionColor ?? defaultColor

for index in 1..<5 {
    print(index)
}

let names = ["jack","michle","jane","rose"]

for name in names[...2] {
    print(name)
}

let n = ...5
n.contains(1)

let quotation = """

The White Rabbit put on his spectacles.  "Where shall I begin,
please your Majesty?" he asked.
 
"Begin at the beginning," the King said gravely, "and go on
till you come to the end; then stop."
"""
print(quotation)
print("sa")
