//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

//初始化

/*
 初始化是为类、结构体或者枚举准备实例的过程。
 这个过需要给实例里的每一个存储属性设置一个初始值并且在新实例可以使用之前执行任何其他所必须的配置或初始化。
*/

//一：为存储属性设置初始化值
/*
 在创建类和结构体的实例时必须为所有的存储属性设置一个合适的初始值。存储属性不能遗留在不确定的状态中
 */
//1.初始化器
//init() {
//
//}
struct Fahrenheit {
    var temperature: Double
    init() {
        temperature = 32.0
    }
}

var f = Fahrenheit()
print("The default temperature is \(f.temperature)° Fahrenheit")
//The default temperature is 32.0° Fahrenheit

//2.默认的属性值
struct Fahrenheit2 {
    var temperature = 32.0
}


//二：自定义初始化
//通过输入形式参数和可选类型来自定义初始化过程，或者在初始化的时候分配常量属性。

//1.初始化形式参数
/*
 提供初始化形式参数作为初始化器的一部分，来定义初始化过程中的类型和值的名称。
 初始化形式参数与函数和方法的形式参数具有相同的功能和语法。
 */

struct Celsius {
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
}

let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
print(boilingPointOfWater.temperatureInCelsius) //100.0
let freezingPointOfWater = Celsius(fromKelvin: 273.15)
print(freezingPointOfWater.temperatureInCelsius) //0.0

//2.形式参数名和实际参数标签
/*
 与函数和方法的形式参数一样，初始化形式参数也可以在初始化器内部有一个局部变量名以及实际参数标签供调用的时候使用。
 初始化器并不能像函数和方法那样在圆括号前面有一个用来区分的函数名。
 因此，一个初始化器的参数名称和类型在识别该调用哪个初始化器的时候就扮演了一个非常重要的角色。
 因此，如果你没有提供外部名 Swift 会自动为每一个形式参数提供一个外部名称。
 */
struct Color {
    let red, green, blue: Double
    init(red: Double, green: Double, blue: Double) {
        self.red = red
        self.green = green
        self.blue = blue
    }
    
    init(white: Double) {
        red = white
        green = white
        blue = white
    }
}
//⚠️：如果定义了外部参数名就必须用在初始化器里，省略的话会报一个编译时错误：
let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
let halfGray = Color(white: 0.5)
print(halfGray.red)//0.5

//3.无实际参数标签的初始化器形式参数
/*
 如果你不想为初始化器形式参数使用实际参数标签，可以写一个下划线( _ )替代明确的实际参数标签以重写默认行为。
 */
struct Celsius2 {
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
    init(_ celsius: Double) {
        temperatureInCelsius = celsius
    }
}
let bodyTemperature = Celsius2(37.0)

//4.可选属性类型
/*
 如果你的自定义类型有一个逻辑上是允许“无值”的存储属性——大概因为它的值在初始化期间不能被设置，
 或者因为它在稍后允许设置为“无值”——声明属性为可选类型。可选类型的属性自动地初始化为 nil ，表示该属性在初始化期间故意设为“还没有值”。
 */
class SurveyQuestion {
    var text: String
    var response: String? //可选属性
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}
let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
cheeseQuestion.ask()
// prints "Do you like cheese?"
cheeseQuestion.response = "Yes, I do like cheese."
cheeseQuestion.text = "change question"
//变量属性可以修改
print(cheeseQuestion.text) //change question

//5.在初始化中分配常量属性
/*
 在初始化的任意时刻，你都可以给常量属性赋值，只要它在初始化结束是设置了确定的值即可。
 一旦为常量属性被赋值，它就不能再被修改了
 */
class SurveyQuestion2 {
    let text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask(){
        print(text)
    }
}
let beetsQuestion = SurveyQuestion2(text: "How about beets?")
beetsQuestion.ask()//How about beets?
beetsQuestion.response = "I also like beets. (But not with cheese.)"
//beetsQuestion.text = "change question"//⚠️ error

//三：默认初始化器
/*
 Swift为所有没有提供初始化器的结构体或类提供了一个默认的初始化器来给所有的属性提供了默认值。
 这个默认的初始化器只是简单地创建了一个所有属性都有默认值的新实例。
 */

class ShoppingListItem {
    var name: String?
    var quantity = 1
    var purchased = false
}
var item = ShoppingListItem()//只有属性都有值，才能使用默认初始化器

//1.结构体类型的成员初始化器
/*
 如果结构体类型中没有定义任何自定义初始化器，它会自动获得一个成员初始化器。
 不同于默认初始化器，结构体会接收 成员初始化器 即使它的 存储属性没有默认值。⚠️
 
 这个成员初始化器是一个快速初始化新结构体实例成员属性的方式。
 新实例的属性初始值可以通过 名称 传递到成员初始化器里。
 */
struct Size {
    var width = 0.0, height = 0.0
}
let twoByTwo = Size(width: 2.0, height: 2.0)//Size 结构体自动接收一个 init(width:heght:) 成员初始化器

//⏰当你调用成员初始化器时，你可以省略任何拥有默认值的属性。
let zeroByTwo = Size(height: 2.0)
print(zeroByTwo.width, zeroByTwo.height)//0.0 2.0

let zeroByZero = Size()
print(zeroByTwo.width, zeroByTwo.height)//0.0 2.0

//四：值类型的 初始化器委托
/*
 初始化器可以调用 其他初始化器 来执行部分实例的初始化。这个过程，就是所谓的初始化器委托，避免了多个初始化器里冗余代码。
 初始化器委托的运作，以及允许那些形式的委托，这些规则对于值类型和类类型是不同的。
 值类型(结构体和枚举)不支持继承，所以它们的初始化器委托的过程相当简单，因为它们只能提供它们自己为另一个初始化器委托。
 对于值类型，当你写自己自定义的初始化器时可以使用 self.init 从相同的值类型里引用其他初始化器。
 你只能从初始化器里调用 self.init 。
 */
struct Size2 {
    var width = 0.0, height = 0.0
}
struct Point {
    var x = 0.0, y = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
    init() {}
    
    init(origin: Point,size: Size) {
        self.origin = origin
        self.size = size
    }
    
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        //调用(或是委托) init(origin:size:) 初始化器
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}


//五：类的继承和初始化
/*
 所有类的存储属性——包括从它的父类继承的所有属性——都必须在初始化期间分配初始值。
 Swift 为类类型定义了两种初始化器1.指定初始化器；2.便捷初始化器
 每个类至少得有一个指定初始化器。便捷初始化器是次要的，可以不需要。
 */

//1.指定初始化器 和 便捷初始化语法
//指定
//init(parameters) {
//    statements
//}

//便捷 convenience
//convenience init(parameters) {
//    statements
//}


//2.类类型的初始化器委托
/*
 规则：1.指定初始化器必须从它的直系父类调用指定初始化器
      2.便捷初始化器必须从相同的类里调用另一个初始化器
      3.便捷初始化器最终必须调用一个指定初始化器。
 指定初始化器必须总是向上委托。
 便捷初始化器必须总是横向委托。
 */

//3.两段式初始化
/*
 Swift的类初始化是一个两段式过程。
 在第一个阶段，每一个存储属性被引入类为分配了一个初始值。一旦每个存储属性的初始状态被确定，
 第二个阶段就开始了，每个类都有机会在新的实例准备使用之前来定制它的存储属性。

两段式初始化过程的使用让初始化更加安全，同时在每个类的层级结构给与了完备的灵活性。
两段式初始化过程可以防止属性值在初始化之前被访问，还可以防止属性值被另一个初始化器意外地赋予不同的值。
 */
/*
 Swift编译器执行四种有效的安全检查来确保两段式初始化过程能够顺利完成
 安全检查 1
 指定初始化器必须保证在向上委托给父类初始化器之前，其所在类引入的所有属性都要初始化完成。

 如上所述，一个对象的内存只有在其所有储存型属性确定之后才能完全初始化。为了满足这一规则，指定初始化器必须保证它自己的属性在它上交委托之前先完成初始化。

 安全检查 2
 指定初始化器必须先向上委托父类初始化器，然后才能为继承的属性设置新值。如果不这样做，指定初始化器赋予的新值将被父类中的初始化器所覆盖。

 安全检查 3
 便捷初始化器必须先委托同类中的其它初始化器，然后再为任意属性赋新值（包括同类里定义的属性）。如果没这么做，便捷构初始化器赋予的新值将被自己类中其它指定初始化器所覆盖。

 安全检查 4
 初始化器在第一阶段初始化完成之前，不能调用任何实例方法、不能读取任何实例属性的值，也不能引用 self 作为值。
 直到第一阶段结束类实例才完全合法。属性只能被读取，方法也只能被调用，直到第一阶段结束的时候，这个类实例才被看做是合法的。
 
 阶段 1
 指定或便捷初始化器在类中被调用；
 为这个类的新实例分配内存。内存还没有被初始化；
 这个类的指定初始化器确保所有由此类引入的存储属性都有一个值。现在这些存储属性的内存被初始化了；
 指定初始化器上交父类的初始化器为其存储属性执行相同的任务；
 这个调用父类初始化器的过程将沿着初始化器链一直向上进行，直到到达初始化器链的最顶部；
 一旦达了初始化器链的最顶部，在链顶部的类确保所有的存储属性都有一个值，此实例的内存被认为完全初始化了，此时第一阶段完成。
 
 阶段 2
 从顶部初始化器往下，链中的每一个指定初始化器都有机会进一步定制实例。初始化器现在能够访问 self 并且可以修改它的属性，调用它的实例方法等等；
 最终，链中任何便捷初始化器都有机会定制实例以及使用 slef 。
 */

//4.初始化器的继承和重写

//当重写父类指定初始化器时，你必须写 override 修饰符，就算你子类初始化器的实现是一个便捷初始化器。
class Vehicle {
    var numberOfWheels = 0
    var description: String {
        return "\(numberOfWheels) wheel(s)"
    }
}
//Vehicle 类只为它的存储属性提供了默认值，并且没有提供自定义的初始化器。因此，如同默认初始化器中描述的那样，它会自动收到一个默认初始化器。默认初始化器(如果可用的话)总是类的指定初始化器

let vehicle = Vehicle()
print("Vehicle: \(vehicle.description)")// Vehicle: 0 wheel(s)

class Bicycle: Vehicle {
    override init() {
        super.init()
        numberOfWheels = 2
    }
}
/*

 子类 Bicycle 定义了一个自定义初始化器 init() 。这个指定初始化器和 Bicycle 的父类的指定初始化器相匹配，所以 Bicycle 中的指定初始化器需要带上 override 修饰符。

 Bicycle 类的 init() 初始化器以调用 super.init() 开始，这个方法作用是调用父类的初始化器。这样可以确保 Bicycle 在修改属性之前它所继承的属性 numberOfWheels 能被 Vehicle 类初始化。

 ⚠️ 子类可以在初始化时修改继承的变量属性，但是不能修改继承过来的常量属性。
 */
//class Test {
//    var num = 0
//    var str: String = "str"
//}
//class SubTest: Test {
//    var bool: Bool = false
//    override init() {
//        super.init()
//        num = 1
//    }
//}
//var subTest = SubTest()
//print(subTest.num)


//5.初始化器的自动继承
/*
 规则1
 如果你的子类没有定义任何指定初始化器，它会自动继承父类所有的指定初始化器。

 规则2
 如果你的子类提供了所有父类指定初始化器的实现——要么是通过规则1继承来的，要么通过在定义中提供自定义实现的——那么它自动继承所有的父类便捷初始化器。
 */

//6.指定和便捷初始化器的实战

class Food {
    var name: String
    init(name: String) {
        self.name = name
    }
    convenience init(){
        self.init(name:"[Unnamed]")
    }
}
// 初始化链：convenience init() -> designated init(name)

let namedMeat = Food(name: "Bacon")// namedMeat's name is "Bacon"

let mysteryMeat = Food()// mysteryMeat's name is "[Unnamed]"

class RecipeIngredient: Food {
    var quantity: Int
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
}

let oneMysteryItem = RecipeIngredient() //使用基础的便捷初始化器init()
let oneBacon = RecipeIngredient(name: "Bacon") //重写父类init(name:)的便捷初始化器
let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)//指定初始化器

class ShoppingListItem2: RecipeIngredient {
    var purchased = false
    var description: String {
        var output = "\(quantity) x \(name)"
        output += purchased ? "☑️" : "❌"
        return output
    }
}
var breakfastList = [
    ShoppingListItem2(),
    ShoppingListItem2(name: "Bacon"),
    ShoppingListItem2(name:"Eggs",quantity: 6),
]
breakfastList[0].name = "Orange juice"
breakfastList[1].purchased = true
for item in breakfastList {
    print(item.description)
}
/*
 1 x Orange juice❌
 1 x Bacon☑️
 6 x Eggs❌
 */

//六：可失败初始化器
/*
 定义类、结构体或枚举初始化时可以失败在某些情况下会管大用。
 这个失败可能由以下几种方式触发，包括给初始化传入无效的形式参数值，或缺少某种外部所需的资源，又或是其他阻止初始化的情况。
 
 在类、结构体或枚举中定义一个或多个可失败的初始化器。通过在 init 关键字后面添加问号( init? )
 */

struct Animal {
    let species: String
    init?(species: String) {
        if species.isEmpty { return nil}
        self.species = species
    }
}
let someCreature = Animal(species: "Giraffe")
// someCreature is of type Animal?, not Animal
if let giraffe = someCreature {
    print("An animal was initialized with a species of \(giraffe.species)")
}

let  anonymousCreature = Animal(species: "")
if anonymousCreature == nil {
    print("The anonymous creature could not be initialized")
}

//1.枚举的可失败初始化器
enum TemperatureUnit {
    case Kelvin, Celsius, Fahrenheit
    init?(symbol: Character) {
        switch symbol {
        case "k":
            self = .Kelvin
        case "C":
            self = .Celsius
        case "F":
            self = .Fahrenheit
        default:
            return nil
        }
    }
}
let fahrenheitUnit = TemperatureUnit(symbol: "F")
if fahrenheitUnit != nil {
    print("This is a defined temperature unit, so initialization succeeded")
}
let unknownUnit = TemperatureUnit(symbol: "x")
if unknownUnit == nil {
    print("This is not a defined temperature unit, so initialization failed")
}

//2.带有原始值枚举的可失败初始化器
/*
 带有原始值的枚举会自动获得一个可失败初始化器 init?(rawValue:) ，该可失败初始化器接收一个名为 rawValue
 的合适的原始值类型形式参数如果找到了匹配的枚举情况就选择其一，或者没有找到匹配的值就触发初始化失败。
 */
enum TemperatureUnit2: Character {
    case Kelvin = "K", Celsius = "C", Fahrenheit = "F"
}
 
let fahrenheitUnit2 = TemperatureUnit2(rawValue: "F")
if fahrenheitUnit2 != nil {
    print("This is a defined temperature unit, so initialization succeeded.")
}
// prints "This is a defined temperature unit, so initialization succeeded."
 
let unknownUnit2 = TemperatureUnit2(rawValue: "X")
if unknownUnit2 == nil {
    print("This is not a defined temperature unit, so initialization failed.")
}
// prints "This is not a defined temperature unit, so initialization failed."


//3.初始化失败的传递
/*
 类，结构体或枚举的可失败初始化器可以横向委托到同一个类，结构体或枚举里的另一个可失败初始化器。类似地，子类的可失败初始化器可以向上委托到父类的可失败初始化器。

 无论哪种情况，如果你委托到另一个初始化器导致了初始化失败，那么整个初始化过程也会立即失败，并且之后任何初始化代码都不会执行。
 可失败初始化器也可以委托其他的非可失败初始化器。通过这个方法，你可以为已有的初始化过程添加初始化失败的条件。
 */
class Product {
    let name: String
    init?(name: String) {
        if name.isEmpty { return nil }
        self.name = name
    }
}
class CartItem: Product {
    let quantity: Int
    init?(name: String, quantity: Int) {
        if quantity < 1 { return nil}
        self.quantity = quantity
        super.init(name: name)
    }
}
if let twoSocks = CartItem(name: "sock", quantity: 2) {
    print("Item: \(twoSocks.name), quantity: \(twoSocks.quantity)")
}
// prints "Item: sock, quantity: 2"
if let zeroShirts = CartItem(name: "shirt", quantity: 0) {
    print("Item: \(zeroShirts.name), quantity: \(zeroShirts.quantity)")
} else {
    print("Unable to initialize zero shirts")
}
// prints "Unable to initialize zero shirts"
if let oneUnnamed = CartItem(name: "", quantity: 1) {
    print("Item: \(oneUnnamed.name), quantity: \(oneUnnamed.quantity)")
} else {
    print("Unable to initialize one unnamed product")
}
//4.重写可失败初始化器
//在子类里重写父类的可失败初始化器
class Document {
    var name: String?
    // this initializer creates a document with a nil name value
    init() {}
    // this initializer creates a document with a non-empty name value
    init?(name: String) {
        self.name = name
        if name.isEmpty { return nil }
    }
}
class AutomaticallyNamedDocument: Document {
    override init() {
        super.init()
        self.name = "[Untitled]"
    }
    override init(name: String) {
        super.init()
        if name.isEmpty {
            self.name = "[Untitled]"
        } else {
            self.name = name
        }
    }
}
//可以在初始化器里使用强制展开来从父类调用一个可失败初始化器作为子类非可失败初始化器的一部分
class UntitledDocument: Document {
    override init() {
        super.init(name: "[Untitled]")!
    }
}

//七：必要初始化器
//在类的初始化器前添加 required  修饰符来表明所有该类的子类都必须实现该初始化器
class SomeClass {
    required init() {
        // initializer implementation goes here
    }
}
//当子类重写父类的必要初始化器时，必须在子类的初始化器前同样添加 required 修饰符以确保当其它类继承该子类时，该初始化器同为必要初始化器。在重写父类的必要初始化器时，不需要添加 override 修饰符
class SomeSubclass: SomeClass {
    required init() {
        //
    }
}

//八：通过闭包和函数来设置属性的默认值
/*
 如果某个存储属性的默认值需要自定义或设置，你可以使用闭包或全局函数来为属性提供默认值。当这个属性属于的实例初始化时，闭包或函数就会被调用，并且它的返回值就会作为属性的默认值。
 */
//class SomeClass {
//    let someProperty: SomeType = {
//        // create a default value for someProperty inside this closure
//        // someValue must be of the same type as SomeType
//        return someValue
//    }() ⚠️ 圆括号表示立即执闭包
//}
/*如果你使用了闭包来初始化属性，请记住闭包执行的时候，实例的其他部分还没有被初始化。这就意味着你不能在闭包里读取任何其他的属性值，即使这些属性有默认值。你也不能使用隐式 self 属性，或者调用实例的方法。
*/
struct Chessboard {
    let boardColors: [Bool] = {
        var temporaryBoard = [Bool]()
        var isBlack = false
        for i in 1...8 {
            for j in 1...8 {
                temporaryBoard.append(isBlack)
                isBlack = !isBlack
            }
            isBlack = !isBlack
        }
        return temporaryBoard
    }()
    func squareIsBlackAt(row: Int, column: Int) -> Bool {
        return boardColors[(row * 8) + column]
    }
}
let board = Chessboard()
print(board.squareIsBlackAt(row: 0, column: 1))//true
print(board.squareIsBlackAt(row: 7, column: 7))//false


//反初始化
/*
 在类实例被释放的时候，反初始化器就会立即被调用。你可以是用deinit
 关键字来写反初始化器，就如同写初始化器要用 init 关键字一样。
 ⚠️反初始化器只在类类型中有效。
 */
//每个类当中只能有一个反初始化器。反初始化器不接收任何形式参数，并且不需要写圆括号：
class ExampleClass {
    deinit {
        //
    }
}
//反初始化器会在实例被释放之前自动被调用。你不能自行调用反初始化器。
//父类的反初始化器可以被子类继承，并且子类的反初始化器实现结束之后父类的反初始化器会被调用。
//父类的反初始化器总会被调用，就算子类没有反初始化器。
