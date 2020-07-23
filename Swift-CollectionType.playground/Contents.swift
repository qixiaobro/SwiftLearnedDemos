//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport


var someInts = [Int]()
var someStrs = Array<String>()

var threeDoubles = Array(repeating: 0.0, count: 3)
var anotherThreeDoubles = Array(repeating:1.1,count: 3)

var sixDoubles = threeDoubles + anotherThreeDoubles

var someStrs2 = ["a","b","c"]

someStrs2.count

if someStrs.isEmpty {
    print("asd")
}

someStrs2.append(contentsOf: ["a","b"])

someStrs2[0]="aa"
print(someStrs2)
someStrs2[1...3] = ["d","f"]
print(someStrs2)

someStrs2.insert("a", at: 0)
someStrs2.remove(at: 0)

for (index,item) in someStrs2.enumerated(){
    print(index,item)
}

var letters = Set<Character>()
letters.insert("a")
letters=[]

var favoriteGenres: Set<String> =  ["Rock", "Classical", "Hip hop"]
someStrs2.contains("0")

favoriteGenres.contains("Rock")
for genre in favoriteGenres.sorted(){
    print(genre)
}


let oddDigits: Set = [1, 3, 5, 7, 9]
let evenDigits: Set = [0, 2, 4, 6, 8]
let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]

oddDigits.union(evenDigits).sorted()
oddDigits.symmetricDifference(singleDigitPrimeNumbers).sorted()


let houseAnimals: Set = ["🐶", "🐱"]
let houseAnimals2: Set = ["🐶", "🐱"]
let farmAnimals: Set = ["🐮", "🐔", "🐑", "🐶", "🐱"]
let cityAnimals: Set = ["🐦", "🐭"]

houseAnimals.isStrictSubset(of: farmAnimals)
houseAnimals.isDisjoint(with: cityAnimals)

var namesOfIntegers = [Int:String]()

var airports:[String:String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
airports["LHD"]="london"
print(airports)
airports["LHD"]="londonedit"
print(airports)
let lhd = airports["LHD"]
airports["LHD"] = nil
airports.removeValue(forKey: "LHD")

for (key,value) in airports {
    print("key\(key):\(value)")
}
for key in airports.keys {
    print("key：\(key)")
}

for value in airports.values {
    print("value：\(value)")
}
