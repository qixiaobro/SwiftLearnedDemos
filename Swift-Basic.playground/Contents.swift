//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

var languageName = "swift"
languageName = "c++"

print(languageName,terminator:"")

typealias aaa = Int
print(aaa.max)

let possiabelNumber = "123"
let converNumber = Int(possiabelNumber)

if converNumber != nil{
    print(converNumber!,terminator:"")
}else{
    print(1)
}
