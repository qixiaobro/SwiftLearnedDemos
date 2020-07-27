//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

//继承
//一个类可以从另一个类继承方法、属性和其他的特性。
//当一个类从另一个类继承的时候，继承的类就是所谓的子类，而这个类继承的类被称为父类。

//一：定义一个基类
//任何不从另一个类继承的类都是所谓的基类

class Vehicle {
    var currentSpeed = 0.0
    var description: String {
        "traveling at \(currentSpeed) miles per hour"
    }
    func makeNoise() {
        
    }
}

let someVehicle = Vehicle()
print("Vehicle:\(someVehicle.description)")//Vehicle:traveling at 0.0 miles per hour

//二：子类
//子类是基于现有类创建新类的行为。
//子类从现有的类继承了一些特征，你可以重新定义它们。你也可以为子类添加新的特征。
//class SomeSubclass: SomeSuperclass {
//
//}

class Bicycle: Vehicle {
    var hasBasket = false
}
let bicycle = Bicycle()
bicycle.hasBasket = true
bicycle.currentSpeed = 15.0
print("Bicycle: \(bicycle.description)")//Bicycle: traveling at 15.0 miles per hour

//子类本身也可以被继承
class Tandem: Bicycle {
    var currentNumberOfPassengers = 0
}

let tandem = Tandem()
tandem.hasBasket = true
tandem.currentNumberOfPassengers = 2
tandem.currentSpeed = 22.0
print("Tandem: \(tandem.description)")//Tandem: traveling at 22.0 miles per hour


//三：重写
//子类可以提供它自己的实例方法、类型方法、实例属性，类型属性或下标脚本的 自定义实现，否则它将会从父类继承。这就所谓的重写
//override

//1.访问父类的方法、属性和下标脚本
//通过使用 super 前缀访问父类的方法、属性或下标脚本
/*
 一个命名为 someMethod() 的重写方法可以通过 super.someMethod() 在重写方法的实现中调用父类版本的 someMethod() 方法；
 一个命名为 someProperty 的重写属性可以通过 super.someProperty 在重写的 getter 或 setter 实现中访问父类版本的 someProperty 属性；
 一个命名为 someIndex 的重写下标脚本可以使用 super[someIndex] 在重写的下标脚本实现中访问父类版本中相同的下标脚本。
 */

//2.重写方法
class Train: Vehicle {
    override func makeNoise() {
        print("Choo Choo")
    }
}
let train = Train()
train.makeNoise()//Choo Choo

//3.重写属性
//重写属性的GETTER和SETTER
//你可以通过在你的子类重写里为继承而来的只读属性添加Getter和Setter来把它用作可读写属性。总之，你不能把一个继承而来的可读写属性表示为只读属性。
class Car: Vehicle {
    var gear = 1
    override var description: String {
        return super.description + " in gear \(gear)"
    }
}

let car = Car()
car.currentSpeed = 25.0
car.gear = 3
print("Car: \(car.description)")//Car: traveling at 25.0 miles per hour in gear 3

//重写属性观察器
//⚠️ 你不能给继承而来的常量存储属性或者只读的计算属性添加属性观察器。这些属性的值不能被设置，所以提供 willSet 或 didSet 实现作为重写的一部分也是不合适的。

class AutomaticCar: Car {
    override var currentSpeed: Double {
        didSet {
            gear = Int(currentSpeed / 10.0) + 1
        }
    }
}
let automatic = AutomaticCar()
 
automatic.currentSpeed = 35.0
 
print("AutomaticCar: \(automatic.description)")
 
// AutomaticCar: traveling at 35.0 miles per hour in gear 4

//四：阻止重写
//你可以通过标记为 终点 来阻止一个方法、属性或者下标脚本被重写。
//通过在方法、属性或者下标脚本的关键字前写 final 修饰符(比如 final var ， final func ， final class func ， final subscript )。

//你可以通过在类定义中在 class 关键字前面写 final 修饰符( final class )标记一整个类为终点。
