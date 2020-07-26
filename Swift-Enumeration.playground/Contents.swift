//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

//枚举enum
//枚举为一组相关值定义了一个通用类型
//枚举成员可以指定任意类型的值来与不同的成员值关联储存

//一：枚举语法
enum SomeEnumeration {
    
}

//在一个枚举中定义的值（比如： north， south， east和 west）就是枚举的成员值（或成员） case关键字则明确了要定义成员值。
enum CompassPoint: CaseIterable {
    case north
    case south
    case east
    case west
}

//成员值出现在同一行中，用逗号隔开
enum Planet {
    case mercury, venus, earth, mars, jupiter, saturn, uranus, neptune
}

//一旦 directionToHead以 CompassPoint类型被声明，你就可以用一个点语法把它设定成不同的 CompassPoint值
var directionToHead = CompassPoint.west
print(directionToHead)
directionToHead = .east
directionToHead = .south

//二：使用Switch语句来匹配枚举值
switch directionToHead {
case .north:
    print("Lots of planets have a north")
case .south:
    print("Watch out for penguins")
case .east:
    print("Where the sun rises")
case .west:
    print("Where the skies are blue")
}
//就像在控制流中所描述的那样，当判断一个枚举成员时， switch语句应该是全覆盖的。
//如果 .west的 case被省略了，那么代码将不能编译，因为这时表明它并没有覆盖 CompassPoint的所有成员。
//要求覆盖所有枚举成员是因为这样可以保证枚举成员不会意外的被漏掉。
//或者添加default

let somePlanet = Planet.earth
switch somePlanet {
case .earth:
    print("Mostly harmless")
default:
    print("Not a safe place for humans")
}

//三：遍历枚举情况（case）
//可以通过在枚举名字后面写 : CaseIterable 来允许枚举被遍历。
//Swift 会暴露一个包含对应枚举类型所有情况的集合名为 allCases 。
enum Beverage: CaseIterable {
    case coffee, tea, juice
}
let numberOfChoices = Beverage.allCases.count
print("\(numberOfChoices) beverage available")
for beverage in Beverage.allCases{
    print(beverage)
}

//四：关联值
//可以定义 Swift 枚举来存储任意给定类型的关联值
enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}

var productBarcode = Barcode.upc(8, 85909, 51226, 3)
print(productBarcode)
productBarcode = .qrCode("ABCDEFGHIJKLMNOP")
print(productBarcode)

switch productBarcode {
case .upc(let numberSystem, let manufacturer, let product, let check):
    print("UPC: \(numberSystem),\(manufacturer),\(product),\(check)")
case .qrCode(let productCode):
    print("QR code: \(productCode).")
}

//对于一个枚举成员的所有的相关值都被提取为常量，或如果都被提取为变量，为了简洁，你可以用一个单独的 var或 let在成员名称前标注
switch productBarcode {
case let .upc(numberSystem, manufacturer, product, check):
    print("UPC : \(numberSystem), \(manufacturer), \(product), \(check).")
case let .qrCode(productCode):
    print("QR code: \(productCode).")
}

//五：原始值
//关联值中条形码的栗子展示了枚举成员是如何声明它们存储不同类型的相关值的。
//作为相关值的另一种选择，枚举成员可以用相同类型的默认值预先填充（称为原始值）
enum ASCIIControlCharacter: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}
//原始值与关联值不同。原始值是当你第一次定义枚举的时候，它们用来预先填充的值

//1.隐式指定的原始值
//当你在操作存储整数或字符串原始值枚举的时候，你不必显式地给每一个成员都分配一个原始值。当你没有分配时，Swift 将会自动为你分配值

// .1 整数值作为原始值，每成员的隐式值都比前一个大一，如果第一个成员没有值，那么它的值是0
enum Planet2: Int {
     case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}

// .2 当字符串被用于原始值，那么每一个成员的隐式原始值则是那个成员的名称
enum CompassPoint2: String {
    case north, south, east, west
}

//可以用rawValue属性来访问枚举成员的原始值
let earthsOrder = Planet2.earth.rawValue //3

let sunsetDirection = CompassPoint2.west.rawValue //west

//2.从原始值初始化
//如果你用原始值类型来定义一个枚举，那么枚举就会自动收到一个可以接受原始值类型的值的初始化器（叫做 rawValue的形式参数）然后返回一个枚举成员或者 nil
let possiblePlanet = Planet2(rawValue: 7) //uranus
//总之，不是所有可能的 Int值都会对应一个行星。因此原始值的初始化器总是返回可选的枚举成员。在上面的例子中， possiblePlanet的类型是 Planet? ，或者“可选项 Planet”
//原始值初始化器是一个可失败初始化器，因为不是所有原始值都将返回一个枚举成员。
let positionToFind = 11
if let somePlanet = Planet2(rawValue: positionToFind) {
    switch somePlanet {
    case .earth:
        print("Mostly harmless")
    default:
        print("Not a safe place for humans")
    }
} else {
    print("There isn't a planet at position \(positionToFind)") //There isn't a planet at position 11
}


//六：递归枚举
//递归枚举是拥有另一个枚举作为枚举成员关联值的枚举。
//你可以在声明枚举成员之前使用 indirect关键字来明确它是递归的。
//enum ArithmeticExpression {
//    case number(Int)
//    indirect case addition(ArithmeticExpression, ArithmeticExpression)
//    indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
//}

//可以在枚举之前写 indirect 来让整个枚举成员在需要时可以递归
indirect enum ArithmeticExpression {
    case number(Int)
    case addition(ArithmeticExpression, ArithmeticExpression)
    case multiplication(ArithmeticExpression, ArithmeticExpression)
}
//下边的代码展示了为 (5 + 4) * 2 创建的递归枚举
let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four)
let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))

//递归函数是一种操作递归结构数据的简单方法。
func evaluate(_ expression: ArithmeticExpression) -> Int {
    switch expression {
    case let .number(value):
        return value
    case let .addition(left, right):
        return evaluate(left) + evaluate(right)
    case let .multiplication(left, right):
        return evaluate(left) * evaluate(right)
    }
}
 
print(evaluate(product)) //18
