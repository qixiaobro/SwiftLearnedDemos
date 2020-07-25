//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

//闭包是可以在你的代码中被传递和引用的功能性独立代码块。

//函数实际上是特殊的闭包
//全局函数是一个有名字但不会捕获任何值的闭包；
//内嵌函数是一个有名字且能从其上层函数捕获值的闭包；
//闭包表达式是一个轻量级语法所写的可以捕获其上下文中常量或变量值的没有名字的闭包。

//优化闭包：
//利用上下文推断形式参数和返回值的类型
//单表达式的闭包可以隐式返回
//简写实际参数名
//尾随闭包语法

//一：闭包表达式
//1.sorted方法
//sorted(by:) 的方法，会根据你提供的排序闭包将已知类型的数组的值进行排序，返回新数组

let names = ["Chris","Alex","Ewa","Barry","Daniella"]
func backward(_ s1: String,_ s2: String) -> Bool {
    s1 > s2
}
var reversedNames = names.sorted(by:backward)

//2.闭包表达式语法
//能够使用常量形式参数、变量形式参数和输入输出形式参数，但不能提供默认值。
//可变形式参数也能使用，但需要在形式参数列表的最后面使用。
//元组也可被用来作为形式参数和返回类型。
 //⚠️ 有一个关键字 in 表示闭包的形式参数类型和返回类型定义已经完成，并且闭包的函数体即将开始。
//{ (parameters) -> (return type) in
//    statements
//}
reversedNames = names.sorted(by:{ (s1: String, s2: String) -> Bool in
    s1 > s2
})

//3.从语境中推断类型
//由于排序闭包为实际参数来传递给方法，Swift 就能推断它的形式参数类型和返回类型。
//因为所有的类型都能被推断，返回箭头 ( ->) 和围绕在形式参数名周围的括号也能被省略
reversedNames = names.sorted(by: {s1, s2 in return s1 > s2})
print(reversedNames)

//4.从单表达式闭包隐式返回
//单表达式闭包能够通过从它们的声明中删掉 return 关键字来隐式返回它们单个表达式的结果
reversedNames = names.sorted(by: { s1, s2 in s1 > s2 } )

//5.简写的实际参数名
//swift自动对行内闭包提供简写实际参数名，可以通过$0,$1,$2等名字来引用闭包的实际参数值
// in 关键字也能被省略
reversedNames = names.sorted(by:{ $0 > $1 })//$0,$1分别是闭包的第一个和第二个String实际参数

//6.运算符函数
//Swift 的 String 类型定义了关于大于号（ >）的特定字符串实现，
//让其作为一个有两个 String 类型形式参数的函数并返回一个 Bool 类型的值。
reversedNames = names.sorted(by: >)


//二：尾随闭包
//将一个很长的闭包表达式作为函数最后一个 实际参数 传递给函数且闭包表达式很长，
//使用尾随闭包将增强函数的可读性。

//1.作为最后一个参数
reversedNames = names.sorted(){$0 > $1}
//2.此函数只有一个实际参数，则可以不写圆括号
reversedNames = names.sorted{$0 > $1}

//3.Array 中的 map(_:) 方法,数组每个元素调用一次闭包，返回一个新数组
let digitNames = [
    0: "Zero",1: "One",2: "Two",  3: "Three",4: "Four",
    5: "Five",6: "Six",7: "Seven",8: "Eight",9: "Nine"
]

let numbers = [16,58,510]
let strings = numbers.map { (number) -> String in //不需指定number的类型，能够从数组中映射的值中推断出来
    var number = number //变量number以闭包的number形式参数初始化，因为函数和闭包的形式参数是常量
    var output = ""
    repeat {
        output = digitNames[number % 10]! + output//感叹号用来强制展开存储在可选返回值下标项的String值
        number /= 10
    } while number > 0
    return output
}
print(strings)

//4.如果函数接收多个闭包，你可省略第一个尾随闭包的实际参数标签，但要给后续的尾随闭包写标签。
//func loadPicture(from server: Server, completion: (Picture) -> Void, onFailure: () -> Void) { //这个栗子会报错
//    if let picture = download("photo.jpg", from: server) {
//        completion(picture)
//    } else {
//        onFailure()
//    }
//}
//loadPicture(from: someServer) { picture in
//    someView.currentPicture = picture
//} onFailure: {
//    print("Couldn't download the next picture.")
//}

//三：捕获值
//一个闭包能够从上下文捕获已被定义的常量和变量。
//即使定义这些常量和变量的原作用域已经不存在，闭包仍能够在其函数体内引用和修改这些值。
func makeIncrement(forIncrement amount: Int) -> () -> Int {
    var runingTotal = 0
    func incrementer() -> Int {
        runingTotal += amount
        return runingTotal
    }
    return incrementer
}
let incrementByTen = makeIncrement(forIncrement: 10)
incrementByTen()
incrementByTen()
//如果你建立了第二个 incrementer ,它将会有一个新的、独立的 runningTotal 变量的引用：
let incrementBySeven = makeIncrement(forIncrement: 7)
incrementBySeven()

//四：闭包是引用类型
//无论你什么时候赋值一个函数或者闭包给常量或者变量，你实际上都是将常量和变量设置为对函数和闭包的引用。
//这也意味着你赋值一个闭包到两个不同的常量或变量中，这两个常量或变量都将指向相同的闭包
let alsoIncrementByTen = incrementByTen
alsoIncrementByTen()


//五：逃逸闭包
//当闭包作为一个实际参数传递给一个函数的时候，我们就说这个闭包逃逸了，因为它是在函数返回之后调用的。
//当你声明一个接受闭包作为形式参数的函数时，你可以在形式参数前写 @escaping 来明确闭包是允许逃逸的。
var completionHandlers: [() -> Void] = []
func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) { //将闭包形式参数添加到外边数组中 需要填写@escaping关键字
    completionHandlers.append(completionHandler)
}

func someFunctionWithNonescapingClosure(closure: () -> Void) {
    closure()
}
//如果 self 指向类的实例，那么在逃逸闭包中引用 self就需要额外注意。在逃逸闭包中捕获 self很容易不小心造成强引用循环
class SomeClass {
    var x = 10
    func doSomething() {
        someFunctionWithEscapingClosure { //是一个逃逸闭包，所以需要显示指定self
            self.x = 100 //self 指向此class
        }
        someFunctionWithNonescapingClosure {
            x = 200
        }
    }
}
let instance = SomeClass()
instance.doSomething()
print(instance.x)
completionHandlers.first?()
print(instance.x)
//如果 self 是结构体或者枚举的实例，你就可以隐式地引用 self 。
//总之，当 self 是结构体或者枚举的实例时，逃逸闭包不能捕获可修改的 self 引用。
//结构体和枚举不允许共享可修改性。
struct SomeStruct {
    var x = 10
    mutating func doSomething() {
        someFunctionWithNonescapingClosure { x = 200 } //ok
//        someFunctionWithEscapingClosure { x = 100} //error
    }
}
//someFunctionWithEscapingClosure 调用在上文中是错误的，因为它在一个异变方法中，
//所以 self 是可编辑的。这就违反了逃逸闭包不能捕获结构体的可编辑引用 self 的规则。

//六：自动闭包 @autoclosure
//自动闭包是一种自动创建的用来把作为实际参数传递给函数的表达式 打包 的闭包
//这个语法的好处在于通过写普通表达式代替显式闭包而使你省略包围函数形式参数的括号。
//自动闭包允许你延迟处理，因此闭包内部的代码直到你调用它的时候才会运行
var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Dabiella"]
print(customersInLine.count)

let customerProvider = { customersInLine.remove(at: 0)}
print(customersInLine.count)
//尽管 customersInLine 数组的第一个元素以闭包的一部分被移除了，但任务并没有执行直到闭包被实际调用。如果闭包永远不被调用，那么闭包里边的表达式就永远不会求值。
print("now serving \(customerProvider())!")
print(customersInLine.count)

func serve(customer customerProvider: () -> String) {
    print("Now serving \(customerProvider())!")
}
serve(customer: { customersInLine.remove(at: 0) } )
//通过 @autoclosure 标志标记它的形式参数使用了自动闭包。
//现在你可以调用函数就像它接收了一个 String 实际参数而不是闭包。
//实际参数自动地转换为闭包，因为 customerProvider 形式参数的类型被标记为 @autoclosure 标记。
func serve(customer customerProvider: @autoclosure () -> String) {
    print("Now serving \(customerProvider())!")
}
serve(customer: customersInLine.remove(at: 0))

//如果你想要自动闭包允许逃逸，就同时使用 @autoclosure 和 @escaping 标志
var customerProviders: [() -> String] = []
func collectCustomerProviders(_ customerProvider: @autoclosure @escaping () -> String) {
    customerProviders.append(customerProvider)
}
collectCustomerProviders(customersInLine.remove(at: 0))
collectCustomerProviders(customersInLine.remove(at: 0))

print("Collected \(customerProviders.count) closures.")

for customerProvider in customerProviders {
    print("Now serving \(customerProvider())!")
}
