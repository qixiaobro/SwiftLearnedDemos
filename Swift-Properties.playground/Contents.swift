//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

//属性
//属性可以将值与特定的类、结构体或者是枚举联系起来。存储属性会存储常量或变量作为实例的一部分，
//反之计算属性会计算（而不是存储）值。计算属性可以由类、结构体和枚举定义。存储属性只能由类和结构体定义。

//一：存储属性

struct FixedLengthRange {
    var firstValue: Int
    let length: Int
}
var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
rangeOfThreeItems.firstValue = 6
//rangeOfThreeItems.length = 3 //error 新的值域创建时 length 已经被创建并且不能再修改，因为这是一个常量属性。

//1.常量结构体实例的存储属性
//如果你创建了一个结构体的实例并且把这个实例赋给常量，你不能修改这个实例的属性，即使是声明为变量的属性
let rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)
// rangeOfFourItems.firstValue = 6 //error Cannot assign to property: 'rangeOfFourItems' is a 'let' constant
//这是由于结构体是值类型。当一个值类型的实例被标记为常量时，该实例的其他属性也均为常量。
//对于类来说则不同，它是引用类型。如果你给一个常量赋值引用类型实例，你仍然可以修改那个实例的变量属性。

//2.延迟存储属性
//延迟存储属性的初始值在其 第一次使用时 才进行计算。
//你可以通过在其声明前标注 lazy 修饰语来表示一个延迟存储属性。
//你必须把延迟存储属性声明为变量（使用 var 关键字），因为它的初始值可能在实例初始化完成之前无法取得。常量属性则必须在初始化完成之前有值，因此不能声明为延迟。
class DataImporter {
    //DataImporter is a class to import data from an external file.
    //The class is assumed to take a non-trivial amount of time to initialize.
    
    var fileName = "data.txt"
    // the DataImporter class would provide data importing functionality here
}

class DataManager {
    lazy var importer = DataImporter()
    var data = [String]()
    // the DataManager class would provide data management functionality here
}
let manager = DataManager()
manager.data.append("some data")
manager.data.append("some more data")
// the DataImporter instance for the importer property has not yet been created

print(manager.importer.fileName)
// the DataImporter instance for the importer property has now been created
// prints "data.txt"

//3.存储属性与实例变量
//Swift 属性没有与之相对应的实例变量，并且属性的后备存储不能被直接访问。

//二：计算属性
//除了存储属性，类、结构体和枚举也能够定义计算属性，而它实际并不存储值。相反，他们提供一个 读取器（getter）和一个可选的设置器(setter)来间接得到和设置其他的属性和值。
struct Point {
    var x = 0.0
    var y = 0.0
}
struct Size {
    var width = 0.0, height = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX,y: centerY)
        }
        set(newCenter) {
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
    }
}
var square = Rect(origin: Point(x: 0.0,y: 0.0),
        size: Size(width: 10.0, height: 10.0))
let initialSquareCenter = square.center
square.center = Point(x: 15.0, y: 15.0)
print("square.origin is now at (\(square.origin.x),\(square.origin.y))")//square.origin is now at (10.0,10.0)

//1.简写设置器（setter)声明
//如果一个计算属性的设置器没有为将要被设置的值定义一个名字，那么他将被默认命名为 newValue
struct AlternativeRect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}

//2.缩写读取器（getter）声明
//如果整个 getter 的函数体是一个单一的表达式，那么 getter 隐式返回这个表达式
struct CompactRect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            Point(x: origin.x + (size.width / 2),
                  y: origin.y + (size.height / 2))
        }
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}
//3.只读计算属性
//一个有读取器但是没有设置器的计算属性就是所谓的只读计算属性。
//只读计算属性返回一个值，也可以通过点语法访问，但是不能被修改为另一个值。
//你必须用 var 关键字定义计算属性——包括只读计算属性——为变量属性，因为它们的值不是固定的。
//let 关键字只用于常量属性，用于明确那些值一旦作为实例初始化就不能更改。
struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
        return width * height * depth
    }
}
let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
print("the volume of fourByFiveByTwo is \(fourByFiveByTwo.volume)")//the volume of fourByFiveByTwo is 40.0

//三：属性观察者
//属性观察者会观察并对属性值的变化做出回应。每当一个属性的值被设置时，属性观察者都会被调用，即使这个值与该属性当前的值相同。
//你可以在如下地方添加属性观察者：
//你定义的存储属性；
//你继承的存储属性；
//你继承的计算属性。

//你可以选择将这些观察者或其中之一定义在属性上：

//willSet 会在该值被存储之前被调用。
//didSet 会在一个新值被存储后被调用。
class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
            print("About to set totalSteps to \(newTotalSteps)")
        }
        //简写
//        willSet {
//            print("About to set totalSteps to \(newValue)")
//        }
        didSet(oldTotalSteps) {
            if totalSteps > oldTotalSteps  {
                print("Added \(totalSteps - oldTotalSteps) steps")
            }
        }
        //简写
//        didSet {
//            if totalSteps > oldValue  {
//                print("Added \(totalSteps - oldValue) steps")
//            }
//        }
    }
}
let stepCounter = StepCounter()
stepCounter.totalSteps = 200
// About to set totalSteps to 200
// Added 200 steps
stepCounter.totalSteps = 360
//About to set totalSteps to 360
//Added 160 steps

//四：属性包装
//属性包装给代码之间添加了一层分离层，它用来管理属性如何存储数据以及代码如何定义属性。
//要定义一个包装，你可创建一个结构体、枚举或者定义了 wrappedValue 属性的类。

@propertyWrapper
struct TwelveOrLess {
    var number = 0
    var wrappedValue: Int {
        get { return number }
        set { number = min(newValue, 12) }
    }
}
//你可在属性前以特性的方式写包装的名字。
struct SmallRectangle {
    @TwelveOrLess var height: Int
    @TwelveOrLess var width: Int
}

var rectangle = SmallRectangle()
print(rectangle.height)//0
rectangle.height = 10
print(rectangle.height)//10
rectangle.height = 13
print(rectangle.height)//12

//也可以在 TwelveOrLess 结构体中显式地包装了自己的属性，而不是用 @TwelveOrLess 这个特性
struct SmallRectangle2 {
    private var _height = TwelveOrLess()
    private var _width = TwelveOrLess()
    var height: Int {
        get { _height.wrappedValue }
        set { _height.wrappedValue = newValue}
    }
    var width: Int {
        get { _width.wrappedValue }
        set { _width.wrappedValue = newValue }
    }
}
//_height 和 _width 属性存储了一个属性包装的实例， TwelveOrLess 。 height 和 width 的 getter 和 setter 包装了 wrappedValue 属性的访问。
var rectangle2 = SmallRectangle2()
print(rectangle2.height)//0
rectangle2.height = 10
print(rectangle2.height)//10
rectangle2.height = 13
print(rectangle2.height)//12

//1.设定包装属性的初始值
//添加自定义初始化器
@propertyWrapper
struct SmallNumber {
    private var maximum: Int
    private var number: Int
    
    var wrappedValue: Int {
        get { return number }
        set { number = min(newValue, maximum) }
    }
    
    init() {
        maximum = 12
        number = 0
    }
    
    init(wrappedValue: Int) {
        maximum = 12
        number = min(wrappedValue, maximum)
    }
    
    init(wrappedValue: Int, maximum: Int) {
        self.maximum = maximum
        number = min(wrappedValue, maximum)
    }
}
//当你给属性应用包装但并不指定初始值时，Swift 使用 init() 初始化器来设置包装
struct ZeroRectangle {
    @SmallNumber var height: Int
    @SmallNumber var width: Int
}
 
var zeroRectangle = ZeroRectangle()
print(zeroRectangle.height, zeroRectangle.width)
// Prints "0 0"

//当你为属性指定一个初始值时，Swift 使用 init(wrappedValue:) 初始化器来设置包装

struct UnitRectangle {
    @SmallNumber var height: Int = 1
    @SmallNumber var width: Int = 1
}
 
var unitRectangle = UnitRectangle()
print(unitRectangle.height, unitRectangle.width)
// Prints "1 1"

//当你在自定义特性后的括号中写实际参数时，Swift 使用接受那些实际参数的初始化器来设置包装。
//比如说，如果你提供初始值和最大值，Swift 使用 init(wrappedValue:maximum:) 初始化器
struct NarrowRectangle {
    @SmallNumber(wrappedValue: 2, maximum: 5) var height: Int
    @SmallNumber(wrappedValue: 3, maximum: 4) var width: Int
}
 
var narrowRectangle = NarrowRectangle()
print(narrowRectangle.height, narrowRectangle.width)
// Prints "2 3"
 
narrowRectangle.height = 100
narrowRectangle.width = 100
print(narrowRectangle.height, narrowRectangle.width)
// Prints "5 4"

//当你包含属性包装实际参数时，你也可以通过赋值来指定初始值
struct MixedRectangle {
    @SmallNumber var height: Int = 1
    @SmallNumber(maximum: 9) var width: Int = 2
}
 
var mixedRectangle = MixedRectangle()
print(mixedRectangle.height)
// Prints "1"
 
mixedRectangle.height = 20
print(mixedRectangle.height) //12
mixedRectangle.width = 10
print(mixedRectangle.width) //9

//2.通过属性包装映射值
//对于包装值来说，包装属性可以通过定义映射值来暴露额外功能
//映射值的名称和包装的值一样，除了它起始于一个美元符号（ $ ）
@propertyWrapper
struct SmallNumber2 {
    var number = 0
    var projectedValue = false
    var wrappedValue: Int {
        get { return number }
        set {
            if newValue > 12 {
                number = 12
                projectedValue = true
            } else {
                number = newValue
                projectedValue = false
            }
        }
    }
}
struct SomeStructure {
    @SmallNumber2 var someNumber: Int
}
var someStructure = SomeStructure()
 
someStructure.someNumber = 4
print(someStructure.$someNumber)
// Prints "false"
 
someStructure.someNumber = 55
print(someStructure.$someNumber)
// Prints "true"


//五：全局和局部变量
//全局常量和变量永远是延迟计算的，与延迟存储属性有着相同的行为。不同于延迟存储属性，全局常量和变量不需要标记 lazy 修饰符。


//六：类型属性
//1.类型属性语法
//在 Swift 中，总之，类型属性是写在类型的定义之中的，在类型的花括号里，并且每一个类型属性都显式地放在它支持的类型范围内。
//使用 static 关键字来声明类型属性。对于类类型的计算类型属性，你可以使用 class 关键字来允许子类重写父类的实现。
struct SomeStructure2 {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 1
    }
}
enum SomeEnumeration {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 6
    }
}
class SomeClass {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 27
    }
    class var overrideableComputedTypeProperty: Int {
        return 107
    }
}


//2.查询和设置类型属性
//类型属性使用点语法来查询和设置，与实例属性一致。总之，类型属性在类里查询和设置，而不是这个类型的实例。

print(SomeStructure2.storedTypeProperty)
// prints "Some value."
SomeStructure2.storedTypeProperty = "Another value."
print(SomeStructure2.storedTypeProperty)
// prints "Another value."
print(SomeEnumeration.computedTypeProperty)
// prints "6"
print(SomeClass.computedTypeProperty)
// prints "27"


struct AudioChannel {
    static let thresholdLevel = 10
    static var maxInputLevelForAllChannels = 0
    var currentLevel: Int = 0 {
        didSet {
            if currentLevel > AudioChannel.thresholdLevel {
                // cap the new audio level to the threshold level
                currentLevel = AudioChannel.thresholdLevel
            }
            if currentLevel > AudioChannel.maxInputLevelForAllChannels {
                // store this as the new overall maximum input level
                AudioChannel.maxInputLevelForAllChannels = currentLevel
            }
        }
    }
}

var leftChannel = AudioChannel()
var rightChannel = AudioChannel()


leftChannel.currentLevel = 7
print(leftChannel.currentLevel)
// prints "7"
print(AudioChannel.maxInputLevelForAllChannels)
// prints "7"


rightChannel.currentLevel = 11
print(rightChannel.currentLevel)
// prints "10"
print(AudioChannel.maxInputLevelForAllChannels)
// prints "10"
