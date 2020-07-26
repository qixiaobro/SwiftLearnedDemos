//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

//类与结构体
//在 Swift 中，你在一个文件中定义一个类或者结构体， 则系统将会自动生成面向其他代码的外部接口。
//1.类与结构体的对比
//共同点
//定义属性用来存储值；
//定义方法用于提供功能；
//定义下标脚本用来允许使用下标语法访问值；
//定义初始化器用于初始化状态；
//可以被扩展来默认所没有的功能；
//遵循协议来针对特定类型提供标准功能。

//不同点
//继承允许一个类继承另一个类的特征;
//类型转换允许你在运行检查和解释一个类实例的类型；
//反初始化器允许一个类实例释放任何其所被分配的资源；
//引用计数允许不止一个对类实例的引用

//1.1定义语法
//类名、结构体名：UpperCamelCase
//属性、方法名：lowerCamelCase
class SomeClass {
    
}
struct SomeStructure {
    
}

struct Resolution {
    var width = 0
    var height = 0
}
class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}

//1.2类与结构体实例
let someResolution = Resolution()
let someVideoMode = VideoMode()

//1.3 访问属性
//使用点语法来访问一个实例的属性
print("The width of someResolution is \(someResolution.width)") //0
//访问子属性
print("The width of someVideoMode is \(someVideoMode.resolution.width)") //0
//修改属性值
someVideoMode.resolution.width = 1280
print("The width of someVideoMode is now \(someVideoMode.resolution.width)") //1280

//1.4结构体类型的成员初始化器
//所有的结构体都有一个自动生成的成员初始化器，你可以使用它来初始化新结构体实例的成员属性。
let vga = Resolution(width: 640, height: 480)
print(vga.width) //640

//2.结构体和枚举是值类型
//值类型是一种当它被指定到常量或者变量，或者被传递给函数时会被拷贝的类型。
//Swift 中所有的基本类型——整数，浮点数，布尔量，字符串，数组和字典——都是值类型，并且都以结构体的形式在后台实现。
let hd = Resolution(width: 1920, height: 1080)
var cinema = hd
print(cinema.width) //1920
cinema.width = 2040
print(cinema.width) //2040
print(hd.width) //1920 并不会因为cinema的width改变而改变，因为是值拷贝

//枚举也是值拷贝
enum CompassPoint {
    case North, South, East, West
}
var currentDirection = CompassPoint.West
let rememberedDirection = currentDirection
currentDirection = .East
if rememberedDirection == .West {
    print("the remembered direction is still .west")//the remembered direction is still .west
}


//3.类是引用类型
//不同于值类型，在引用类型被赋值到一个常量，变量或者本身被传递到一个函数的时候它是不会被拷贝的。相对于拷贝，这里使用的是同一个对现存实例的引用。
let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0

let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0

print("The frameRate property of tenEighty is now \(tenEighty.frameRate)")
//注意 tenEighty和 alsoTenEighty都被声明为常量。然而，你仍然能改变 tenEighty.frameRate和 alsoTenEighty.frameRate因为 tenEighty和 alsoTenEighty常量本身的值不会改变。
//tenEighty和 alsoTenEighty本身是并没有存储 VideoMode实例—相反，它们两者都在后台指向了 VideoMode实例。
//这是 VideoMode的 frameRate参数在改变而不是 引用 VideoMode的常量的值 在改变。

//3.1特征运算符
// === 相同于
// !== 不相同于

//“相同于” === 意味着两个类类型常量或者变量 引用 自相同的实例；
//“等于” == 意味着两个实例的在 值 上被视作“相等”或者“等价”，某种意义上的“相等”，就如同类设计者定义的那样。

//3.2 指针

//4.类和结构体之间的选择
//按照通用准则，当符合以下一条或多条情形时应考虑创建一个结构体：

//结构体的主要目的是为了封装一些相关的简单数据值；
//当你在赋予或者传递结构实例时，有理由需要封装的数据值被拷贝而不是引用；
//任何存储在结构体中的属性是值类型，也将被拷贝而不是被引用；
//结构体不需要从一个已存在类型继承属性或者行为。

//5.字符串、数组和字典的赋值于拷贝行为
//Swift 的 String , Array 和 Dictionary类型是作为结构体来实现的，这意味着字符串，数组和字典在它们被赋值到一个新的常量或者变量，亦或者它们本身被传递到一个函数或方法中的时候，其实是传递了拷贝。

//这种行为不同于基础库中的 NSString, NSArray和 NSDictionary，它们是作为类来实现的，而不是结构体。 NSString , NSArray 和 NSDictionary实例总是作为一个已存在实例的引用而不是拷贝来赋值和传递。
//数组和字典“拷贝”的描述中。你在代码中所见到的行为好像总是拷贝。然而在后台 Swift 只有在需要这么做时才会实际去拷贝。Swift 能够管理所有的值的拷贝来确保最佳的性能，所有你也没必要为了保证最佳性能来避免赋值。
