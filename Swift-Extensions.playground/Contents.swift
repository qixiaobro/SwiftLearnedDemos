//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

//扩展

/*
 扩展为现有的类、结构体、枚举类型、或协议添加了新功能。这也包括了为无访问权限的源代码扩展类型的能力（即所谓的逆向建模）。
 */
/*
 Swift 中的扩展可以：

 添加计算实例属性和计算类型属性；
 定义实例方法和类型方法；
 提供新初始化器；
 定义下标；
 定义和使用新内嵌类型；
 使现有的类型遵循某协议
 */

//1.扩展的语法 extension关键字

//extension SomeType {
//    //
//}

//扩展可以使已有的类型遵循一个或多个协议。
//在这种情况下，协议名的书写方式与类或结构体完全一样
//extension SomeType: SomeProtocol, AnotherProtocol {
//
//}

//计算属性
//扩展可以向已有的类型添加计算实例属性和计算类型属性。

extension Double {
    var km: Double { return self * 1_000.0 }
    var m: Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0 }
    var ft: Double { return self / 3.28084 }
}

let oneInch = 25.4.mm
print("One inch is \(oneInch) meters")
//One inch is 0.0254 meters
let threeFeet = 3.ft
print("Three feet is \(threeFeet) meters")
//Three feet is 0.914399970739201 meters
/*
 这些计算属性表述了Double值应被看作是确定的长度单位。
 尽管它们被实现为计算属性，这些属性的名字仍可使用点符号添加在浮点型的字面量之后，
 作为一种使用该字面量来执行距离转换的方法。
 
 上述属性为只读计算属性，为了简洁没有使用 get 关键字。
 他们都返回 Double 类型的值，可用于所有使用 Double 值的数学计算中：
 */
let aMarathon = 42.km + 195.m
print("A marathon is \(aMarathon) meters long")
//A marathon is 42195.0 meters long

//⚠️扩展可以添加新的计算属性，但是不能添加存储属性，也不能向已有的属性添加属性观察者。


//2.初始化器
/*
 扩展可向已有的类型添加新的初始化器。这允许你扩展其他类型以使初始化器接收你的自定义类型作为形式参数
 或提供该类型的原始实现中未包含的额外初始化选项。
 
 扩展能为类添加新的便捷初始化器，但是不能为类添加指定初始化器或反初始化器。
 指定初始化器和反初始化器 必须由原来类的实现提供。
 
 如果你使用扩展为一个值类型添加初始化器，且该值类型为其所有储存的属性提供默认值，而又不定义任何自定义初始化器时，你可以在你扩展的初始化器中调用该类型默认的初始化器和成员初始化器。
 */

struct Size {
    var width = 0.0, height = 0.0
}
struct Point {
    var x = 0.0, y = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
}
/*
 如同默认初始化器中描述的那样，
由于 Rect结构体为其所有属性提供了默认值，它将自动接收一个默认的初始化器和一个成员初始化器。
 这些初始化器能用于创建新的 Rect 实例：
 */
let defaultRect = Rect()
let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0), size: Size(width: 5.0, height: 5.0))

//扩展 Rect 结构体以额外提供一个接收特定原点和大小的初始化器：
extension Rect {
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}
let centerRect = Rect(center: Point(x: 4.0, y: 4.0), size: Size(width: 3.0, height: 3.0))

//3.方法
//扩展可以为已有的类型添加新的实例方法和类型方法。

//下面的🌰为 Int 类型添加了一个名为 repetitions 的新实例方法：
extension Int {
    func repetitions(task: () -> Void) {
        for _ in 0..<self {
            task()
        }
    }
}

3.repetitions {
    print("Hello!")
}

//异变实例方法
//增加了扩展的实例方法仍可以修改（或异变）实例本身。mutating
extension Int {
    mutating func square() {
        self = self * self
    }
}

var someInt = 3
someInt.square()//9

//4.下标
//扩展能为已有的类型添加新的下标。

//下面的🌰为 Swift 内建的 Int 类型添加了一个整型下标。
//这个下标 [n] 返回了从右开始第 n 位的十进制数字：
extension Int {
    subscript(digitIndex: Int) -> Int {
        var decimalBase = 1
        for _ in 0..<digitIndex {
            decimalBase *= 10
        }
        return (self / decimalBase) % 10
    }
}
746381295[0] //5

//5.内嵌类型
//扩展可以为已有的类、结构体和枚举类型添加新的内嵌类型
extension Int {
    enum Kind {
        case negative, zero, positive
    }
    var kind: Kind { //计算实例属性
        switch self {
        case 0:
            return .zero
        case let x where x > 0:
            return .positive
        default:
            return .negative
        }
    }
}

func printIntegerKinds(_ numbers: [Int]) {
    for number in numbers {
        switch number.kind {
        case .negative:
            print("- ", terminator: "")
        case .zero:
            print("0 ", terminator: "")
        case .positive:
            print("+ ", terminator: "")
        }
    }
}
printIntegerKinds([3, 19, -27, 0, -6, 0, 7])
