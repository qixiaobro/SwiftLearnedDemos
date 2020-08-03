//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

//可选链
/*
 可选链是一个调用和查询可选属性、方法和下标的过程，它可能为 nil
*/

//1.可选链代替强制展开
/*
 你可以通过在你希望如果可选项为非 nil 就调用属性、方法或者脚本的可选值后边使用问号（ ? ）来明确可选链。这和在可选值后放叹号（ ! ）来强制展开它的值非常类似。
 主要的区别在于可选链会在可选项为 nil 时得体地失败，而强制展开则在可选项为 nil 时触发运行时错误。
*/
class Person {
    var residence: Residence?
}

class Residence {
    var numberOfRooms = 1
}

let john = Person()

//let roomCount = john.residence!.numberOfRooms //error
//使用可选链来访问numberOfRooms
if let roomCount = john.residence?.numberOfRooms {//这将会告诉 Swift 把可选 residence 属性“链接”起来并且取回 numberOfRooms 的值，如果 residence 存在的话。
    print("Johb's residence has \(roomCount) room(s)")
} else {
    print("Unable to receive the number of rooms.")
}
//Unable to receive the number of rooms.
//事实上通过可选链查询就意味着对 numberOfRooms 的调用一定会返回 Int? 而不是 Int 。
john.residence = Residence()
if let roomCount = john.residence?.numberOfRooms {
    print("Johb's residence has \(roomCount) room(s)")
} else {
    print("Unable to receive the number of rooms.")
}
//Johb's residence has 1 room(s)


//2.为可选链定义模型类
//可以使用可选链来调用属性、方法和下标不止一个层级。这允许你在相关类型的复杂模型中深入到子属性，并检查是否可以在这些自属性里访问属性、方法和下标。
class Person2 {
    var residence: Residence2?
}
class Residence2 {
    var rooms = [Room]()
    var numberOfRooms: Int {
        return rooms.count
    }
    subscript(i: Int) -> Room {
        get {
            return rooms[i]
        }
        set {
            rooms[i] = newValue
        }
    }
    func printNumberOfRooms() {
        print("The number of rooms is \(numberOfRooms)")
    }
    var address: Address?
}
class Room {
    let name: String
    init(name: String) { self.name = name }
}
class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    func buildingIdentifier() -> String? {
        if buildingName != nil {
            return buildingName
        } else if buildingNumber != nil && street != nil {
            return "\(buildingNumber)\(street)"
        } else {
            return nil
        }
    }
}

//3.通过可选链访问属性
//你可以使用可选链来访问可选值里的属性，并且检查这个属性的访问是否成功。
let zxd = Person2()

let someAddress = Address()
someAddress.buildingNumber = "29"
someAddress.street = "Acacia Road"
zxd.residence?.address = someAddress//给 john.residence 的 address 属性赋值会失败，因为 john.residence 目前是 nil 。
//这个赋值是可选链的一部分，也就是说 = 运算符右手侧的代码都不会被评判。
func createAddress() -> Address {
    print("Function was called")
    
    let someAddress = Address()
    someAddress.buildingNumber = "29"
    someAddress.street = "Acacia Road"
    
    return someAddress
}
zxd.residence?.address = createAddress() //没有输出  证明createAddress()函数没有被调用

//4.通过可选链调用方法
//你可以使用可选链来调用可选项里的方法，并且检查调用是否成功。甚至可以在没有定义返回值的方法上这么做
//当你通过可选链调用的时候返回值一定会是一个可选类型。
if zxd.residence?.printNumberOfRooms() != nil {
    print("It was possible to print the number of rooms.")
} else {
    print("It was not possible to print the number of rooms.")
}

//5.通过可选链访问下标和赋值

if let firstRoomName = zxd.residence?[0].name {
    print("The first room name is \(firstRoomName).")
} else {
    print("Unable to retrieve the first room name.")
}

zxd.residence?[0] = Room(name: "Bathroom")


let johnsHouse = Residence2()
johnsHouse.rooms.append(Room(name: "Living Room"))
johnsHouse.rooms.append(Room(name: "Kitchen"))
zxd.residence = johnsHouse
 
if let firstRoomName = zxd.residence?[0].name {
    print("The first room name is \(firstRoomName).")
} else {
    print("Unable to retrieve the first room name.")
}
// Prints "The first room name is Living Room."

//访问可选类型的下标
var testScores = ["Dave": [86, 82, 84], "Bev": [79, 94, 81]]
testScores["Dave"]?[0] = 91
testScores["Bev"]?[0] += 1
testScores["Brian"]?[0] = 72
// the "Dave" array is now [91, 82, 84] and the "Bev" array is now [80, 94, 81]
print(testScores)

//6.链的多层链接
/*
 你可以通过连接多个可选链来在模型中深入访问属性、方法以及下标。总之，多层可选链不会给返回的值添加多层的可选性。

 也就是说：

 如果你访问的值不是可选项，它会因为可选链而变成可选项；
 如果你访问的值已经是可选的，它不会因为可选链而变得更加可选。
 因此：

 如果你尝试通过可选链取回一个 Int 值，就一定会返回 Int? ，不论通过了多少层的可选链；
 类似地，如果你尝试通过可选链访问 Int? 值， Int? 一定就是返回的类型，无论通过了多少层的可选链。
 */
if let johnsStreet = zxd.residence?.address?.street {
    print("John's street name is \(johnsStreet).")
} else {
    print("Unable to retrieve the address.")
}
// Prints "Unable to retrieve the address."

//用可选链返回值链接方法
//可以通过可选链来调用返回可选类型的方法，并且如果需要的话可以继续对方法的返回值进行链接。
if let buildingIdentifier = zxd.residence?.address?.buildingIdentifier() {
    print("John's building identifier is \(buildingIdentifier).")
}
// Prints "John's building identifier is The Larches."
//如果你要进一步对方法的返回值进行可选链，在方法 buildingIdentifier() 的圆括号后面加上可选链问号：
if let beginsWithThe =
    zxd.residence?.address?.buildingIdentifier()?.hasPrefix("The") {
        if beginsWithThe {
            print("John's building identifier begins with \"The\".")
        } else {
            print("John's building identifier does not begin with \"The\".")
        }
}
// Prints "John's building identifier begins with "The"."
