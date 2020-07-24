//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

//func
func greet(person: String) -> String{
    let greeting = "Hello \(person)!"
    return greeting
}

print(greet(person: "zxd"))

func greetAgain(person: String) -> String {
    return "Hello again,\(person)!"
}
print(greetAgain(person: "zxd"))

//无形参函数
func sayHelloWorld() -> String {
    return "hello world!"
}
print(sayHelloWorld())

//多形参函数 此参数虽与上面那个greet函数同名 但是却不是同一个函数
func greet(person: String, alreadyGreeted: Bool) -> String {
    if alreadyGreeted {
        return greetAgain(person: person)
    } else {
        return greet(person: person)
    }
}
print(greet(person: "zxd", alreadyGreeted: true))

//无返回值的函数，函数定义时不需包含箭头（->)，其实有返回值 是void 一个空的元组()
//func greet(person: String) {
//    print("Hello,\(person)!")
//}
//greet(person: "Dave")

//函数返回值可以被忽略
func printAndCount(string: String) -> Int{
    print(string)
    return string.count
}
func printWithoutCounting(string: String) {
    let _ = printAndCount(string: string) //忽略返回值，如果用别的变量名，会报定义未使用的经过⚠️
}
printAndCount(string: "hello,world!")
printWithoutCounting(string: "hello,world!")

//多返回值的函数，使用元组作为返回类型
//func minMax(array: [Int]) -> (min: Int,max: Int) {
//    var currentMin = array[0]
//    var currentMax = array[0]
//    for value in array[1..<array.count] {
//        if value < currentMin{
//            currentMin = value
//        }else if value > currentMax {
//            currentMax = value
//        }
//    }
//    return (currentMin, currentMax)
//}
//
//let bounds = minMax(array: [8, -6, 2, 109, 3, 71])
//print("min is \(bounds.min),max is \(bounds.max)!")

//可选元组返回类型
    //如果元组在函数的返回类型中有可能没有值，
    //可以在可选元组类型的圆括号后边添加一个问号（ ?）
    //⚠️ (Int, Int)? 和 (Int?, Int?) 是不同的。
func minMax(array: [Int]) -> (min: Int, max: Int)? {
    if array.isEmpty {return nil}
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin{
            currentMin = value
        }else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}
if let bounds = minMax(array: [8,-6,2,109,3,71]) {
    print("min is \(bounds.min),max is \(bounds.max)!")
}
if let bounds = minMax(array: []) {
    print("min is \(bounds.min),max is \(bounds.max)!")
}else {
    print("array is empty!")
}


//隐式返回的函数
//你写的任何只有一行 return 的函数都可以省略那个 return
//⚠️ 属性的 getter 同样可以使用隐式返回
func greeting(for person: String) -> String {
    "Hello, \(person) !"
}
print(greeting(for: "Dave"))

//函数实际参数标签和形式参数名
//1.指定实际参数标签
//func someFunction(argumentLabel parameterName: Int) {
//
//}
func greet(person: String, from hometown: String) -> String {
    "Hello \(person)!  Glad you could visit from \(hometown)."
}
print(greet(person: "bill", from: "Cupertino"))

//2.省略实际参数标签
//如果对于函数的形式参数不想使用实际参数标签的话，
//利用下划线（ _ ）来为这个形式参数代替显式的实际参数标签。
//func someFunction(_ firstParamterName: Int, secondParamterName: Int) {
//
//}
//someFunction(1, secondParamterName: 2)

//3.默认形式参数值
func someFunction(parameterWithDefault: Int = 12) {
    print(parameterWithDefault)
}
someFunction(parameterWithDefault: 6)
someFunction()

//4.可变形式参数
//一个可变形式参数可以接受零或者多个特定类型的值。
//可以通过在形式参数的类型名称后边插入三个点符号（ ...）来书写可变形式参数。
//传入到可变参数中的值在函数的主体中被当作是对应类型的数组
func arithmeticMean(_ numbers: Double...) -> Double {
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}
arithmeticMean(1, 2, 3, 4, 5)
arithmeticMean(1, 2, 3)

//5.输入输出形式参数
//函数修改在外部定义的变量
//在形式参数类型前加上 inout 定义一个输入输出形式参数
//调用函数时在实际参数前加上&
func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporasyA = a
    a = b
    b = temporasyA
}
var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
print(someInt,anotherInt)

//函数类型
//1.使用函数类型
func addTwoInts(_ a: Int, _ b: Int) -> Int {
    return a + b
}
var mathFunction: (Int, Int) -> Int = addTwoInts
// 简写
let anotherMathFunction = addTwoInts
print("Result: \(mathFunction(2,3))")

//2.函数类型作为形式参数类型
func printMathResult(_ mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
    print("Result:\(mathFunction(a,b))")
}
printMathResult(addTwoInts, 3, 5)

//3.函数类型作为返回类型
func stepForward(_ input: Int) -> Int {
    return input + 1
}
func stepBackward(_ input: Int) -> Int {
    return input - 1
}
func chooseStepFunction(backwards: Bool) -> (Int) -> Int {
    backwards ? stepForward : stepBackward
}
let choisedFun = chooseStepFunction(backwards: true)
print(choisedFun(3))


//内嵌函数
//在函数的内部定义另外一个函数
func chooseStepFunction(backward: Bool) -> (Int) -> Int {
    func stepForward(input: Int) -> Int { return input + 1 }
    func stepBackward(input: Int) -> Int { return input - 1 }
    return backward ? stepBackward : stepForward
}
