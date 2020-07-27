//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

//方法
//方法 是关联了特定类型的函数。类，结构体以及枚举都能定义实例方法，方法封装了给定类型特定的任务和功能。类，结构体和枚举同样可以定义类型方法，这是与类型本身关联的方法。


//一：实例方法
//实例方法 是属于特定类实例、结构体实例或者枚举实例的函数。
//他们为这些实例提供功能性，要么通过提供访问和修改实例属性的方法，要么通过提供与实例目的相关的功能。
//实例方法与函数的语法完全相同，就如同函数章节里描述的那样。
class Counter {
    var count = 0
    func increment(){
        count += 1
    }
    func increment(by amount: Int) {
        count += amount
    }
    func reset(){
        count = 0
    }
}

let counter = Counter()
counter.increment()
print(counter.count)//1
counter.increment(by: 5)
print(counter.count)//6
counter.reset()
print(counter.count)//0

//1.self属性
//每一个类的 实例 都隐含一个叫做 self的属性，它完完全全与 实例本身 相等。你可以使用 self属性来在 当前实例 当中调用它自身的方法。
//上面的🌰可以这样写，但是一般swift会自动推断
//func reset(){
//    self.count = 0
//}

//例外⚠️
//当一个实例方法的 形式参数名 与实例中 某个属性 拥有相同的名字的时候，形式参数名具有优先级
struct Point {
    var x = 0.0, y = 0.0
    func isToTheRightOf(x: Double) -> Bool {
        return self.x > x //self就避免了叫做 x 的方法形式参数还是同样叫做 x 的实例属性这样的歧义
    }
}
let somePoint = Point(x: 4.0, y: 5.0)
if somePoint.isToTheRightOf(x: 1.0) {
    print("This point is to the right of the line where x == 1.0")
}


//2.在实例方法中修改值类型
//结构体和枚举是值类型。默认情况下，值类型属性不能被自身的实例方法修改
//如果你需要在特定的方法中修改结构体或者枚举的属性，你可以选择将这个方法异变
//在 func关键字前放一个 mutating关键字来使用这个行为
struct Point2 {
    var x = 0.0, y = 0.0
    mutating func moveBy(x: Double,y: Double){
        self.x = x
        self.y = y
    }
}
var somePoint2 = Point2()
somePoint2.moveBy(x: 2, y: 3)
print("The point is now at (\(somePoint2.x), \(somePoint2.y))")

//注意⚠️
//不能在常量结构体类型里调用异变方法，因为自身属性不能被改变，就算它们是变量属性
//let fixedPoint = Point2(x: 2, y: 3)
//fixedPoint.moveBy(x: 3, y: 3)//error

//3.在异变方法里指定自身
//异变方法可以指定整个实例给隐含的 self属性
struct Point3 {
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX: Double,y deltaY: Double) {
        self = Point3(x: deltaX, y: deltaY)
    }
}

//枚举的异变方法可以设置隐含的 self属性为相同枚举里的不同成员
enum TriStateSwitch {
    case off, low, high
    mutating func next() {
        switch self {
        case .off:
            self = .low
        case .low:
            self = .high
        case .high:
            self = .off
        }
    }
}

var ovenLight = TriStateSwitch.low
ovenLight.next()
ovenLight.next()


//二：类型方法
//实例方法是特定类型实例中调用的方法。
//你同样可以定义在类型本身调用的方法。这类方法被称作类型方法。
//通过在 func关键字之前使用 static关键字来明确一个类型方法。
//类同样可以使用 class关键字来允许子类重写父类对类型方法的实现。
//类型方法和实例方法一样使用点语法调用。不过，你得在类上调用类型方法，而不是这个类的实例。
class SomeClass {
    class func someTypeMethod() {
        
    }
}
SomeClass.someTypeMethod()

//在类型方法的函数体中，隐含的 self属性指向了类本身而不是这个类的实例。

//🌰
/*下边的栗子定义了一个叫做
 LevelTracker的结构体，它通过不同的等级或者阶层来追踪玩家的游戏进度。这是一个单人游戏，但是可以在一个设备上储存多个玩家的信息。

当游戏第一次开始的时候所有的的游戏等级（除了第一级）都是锁定的。每当一个玩家完成一个等级，那这个等级就对设备上的所有玩家解锁。 LevelTracker结构体使用类型属性和方法来追踪解锁的游戏等级。它同样追踪每一个独立玩家的当前等级。
 */
struct LevelTracker {
    //LevelTracker结构体持续追踪任意玩家解锁的最高等级。这个值被储存在叫做 highestUnlockedLevel的类型属性里边。
    static var highestUnlockedLevel = 1 //对全部玩家来说，当前最高解锁等级
    var currentLevel = 1  //当前等级
    
    static func unlock(_ level: Int) { //解锁
        if level > highestUnlockedLevel { highestUnlockedLevel = level }
    }
    
    static func isUnlocked(_ level: Int) -> Bool { //是否解锁
        return level <= highestUnlockedLevel
    }
    
    @discardableResult //当有返回值的方法未得到接收和使用时会有警告  此方法可以取消警告
    mutating func advance(to level: Int) -> Bool {
        if LevelTracker.isUnlocked(level) {
            currentLevel = level
            return true
        } else {
            return false
        }
    }
}

//Player类创建了一个新的 LevelTracker实例 来追踪玩家的进度。它同时提供了一个叫做 complete(level:)的方法，这个方法在玩家完成一个特定等级的时候会被调用。这个方法会为所有的玩家解锁下一个等级并且更新玩家的进度到下一个等级。
class Player {
    var tracker = LevelTracker()
    let playerName: String
    func complete(level: Int) {
        LevelTracker.unlock(level + 1)
        tracker.advance(to: level + 1 ) 
    }
    init(name: String){
        playerName = name
    }
}

var player = Player(name: "zxd")
player.complete(level: 1)
print("highest unlocked level is now \(LevelTracker.highestUnlockedLevel)")

player = Player(name: "zhy")
if player.tracker.advance(to: 6){
        print("player is now on level 6")
} else {
        print("level 6 has not yet been unlocked")
}
