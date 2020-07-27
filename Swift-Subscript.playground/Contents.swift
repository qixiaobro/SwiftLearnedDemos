//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

//下标

//类、结构体和枚举可以定义下标，它可以作为访问集合、列表或序列成员元素的快捷方式

//1.下标的语法
/*
 下标脚本允许你通过在实例名后面的方括号内写一个或多个值对该类的实例进行查询。它的语法类似于实例方法和计算属性。使用关键字 subscript 来定义下标，并且指定一个或多个输入形式参数和返回类型，与实例方法一样。与实例方法不同的是，下标可以是读写也可以是只读的。这个行为通过与计算属性中相同的 getter 和 setter 传达
 */
//subscript(index: Int) -> Int {
//    get {
//
//    }
//    set(newValue) {
//
//    }
//}

//与只读计算属性一样，你可以给只读下标省略 get 关键字
//subscript(index: Int) -> Int {
//    // return an appropriate subscript value here
//}
struct TimesTable {
    let multiplier: Int
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}
let threeTimesTable = TimesTable(multiplier: 3)
print("six times three is \(threeTimesTable[6])")//18


//2.下标用法
/*
 “下标”确切的意思取决于它使用的上下文。通常下标是用来访问集合、列表或序列中元素的快捷方式。你可以在你自己特定的类或结构体中自由实现下标来提供合适的功能。
 */

//3.下标选项
/*下标可以接收任意数量的输入形式参数，并且这些输入形式参数可以是任意类型。下标也可以返回任意类型。下标可以使用变量形式参数和可变形式参数，但是不能使用输入输出形式参数或提供默认形式参数值。
*/
struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating: 0.0, count: rows * columns)
    }
    
    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    subscript(row: Int,column: Int) -> Double {
        get {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}

var matrix = Matrix(rows: 2, columns: 2)
matrix[0, 1] = 1.5
matrix[1, 0] = 3.2
print(matrix)
//let someValue = matrix[2,2]//越界

//类型下标
//通过在 subscript 关键字前加 static 关键字来标记类型下标。在类里则使用 class 关键字，这样可以允许子类重写父类的下标实现。
enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
    static subscript(n: Int) -> Planet {
        return Planet(rawValue: n)!
    }
}
let mars = Planet[4]
print(mars)


