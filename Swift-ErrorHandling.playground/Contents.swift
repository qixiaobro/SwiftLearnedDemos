//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

//错误处理

//一：表示和抛出错误 通过throw语句抛出错误
enum VendingMachineError: Error {
    case invalidSelection
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
}
//throw VendingMachineError.insufficientFunds(coinsNeeded: 5)

//二：处理错误

//1.使用抛出函数传递错误
/*
 为了明确一个函数或者方法可以抛出错误，你要在它的声明当中的形式参数后边写上 throws关键字。使用 throws标记的函数叫做抛出函数。如果它明确了一个返回类型，那么 throws关键字要在返回箭头 ( ->)之前。
 */

//func canThrowErrors() throws -> String
//func cannotThrowErrors() -> String
//🌰
/*
 VendingMachine类拥有一个如果请求的物品不存在、卖光了或者比押金贵了就会抛出对应的 VendingMachineError错误的 vend(itemNamed:)方法
 */
struct Item {
    var price: Int
    var count: Int
}

class VendingMachine {
    var inventory = [
        "Candy Bar": Item(price: 12, count: 7),
        "Chips": Item(price: 10, count: 4),
        "Pretzels": Item(price: 7, count: 11)
    ]
    var coinsDeposited = 0
    
    func vend(itemNamed name: String) throws {
        guard let item = inventory[name] else {
            throw VendingMachineError.invalidSelection
        }
        
        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }
        
        guard item.price <= coinsDeposited else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }
        
        coinsDeposited -= item.price
        
        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem
        
        print("Dispensing \(name)")
    }
}

//由于 vend(itemNamed:)方法传递它抛出的任何错误，所以你调用它的代码要么直接处理错误——使用 do-catch语句， try?或者 try!——要么继续传递它们。


let favoriteSnacks = [
    "Alice": "Chips",
    "Bob": "Licorice",
    "Eve": "Pretzels",
]
func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    try vendingMachine.vend(itemNamed: snackName)
}
struct PurchasedSnack {
    let name: String
    init(name: String, vendingMachine: VendingMachine) throws {
        try vendingMachine.vend(itemNamed: name)
        self.name = name
    }
}

//2.使用DO-Catch处理错误
/*
 可在 catch 后写一个模式来表示这个分句能够处理何种错误。如果 catch 分句没有包含模式，
 那么这个分句就会匹配所有错误并且把这个错误绑定到一个本地变量 error 上
 */
//do {
//    try expression
//    statements
//} catch pattern 1 {
//    statements
//} catch pattern 2 where condition {
//    statements
//} catch pattern 3, pattern 4 where condition {
//    statements
//} catch {
//    statements
//}

var vendingMachine = VendingMachine()
vendingMachine.coinsDeposited = 8
do {
    try buyFavoriteSnack(person: "Alice", vendingMachine: vendingMachine)
    print("Success! Yum.")
} catch VendingMachineError.invalidSelection {
    print("Invalid Selection.")
} catch VendingMachineError.outOfStock {
    print("Out of Stock.")
} catch VendingMachineError.insufficientFunds(let coinsNeeded) {
    print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
} catch {
    print("Unexpected error: \(error).")
}

//任何非 VendingMachineError 的错误都会在调用函数中处理 ⚠️ is
func nourish(with item: String) throws {
    do {
        try vendingMachine.vend(itemNamed: item)
    } catch is VendingMachineError {
        print("Couldn't buy that from the vending machine.")
    }
}

do {
    try nourish(with: "Beet-Flavored Chips")
} catch {
    print("Unexpected non-vending-machine-related error: \(error)")
}


//做多个相关错误的方法是在 catch 后列举他们，用逗号分隔。
//func eat(item: String) throws {
//    do {
//        try vendingMachine.vend(itemNamed: item)
//    } catch VendingMachineError.invalidSelection, VendingMachineError.insufficientFunds, VendingMachineError.outOfStock {
//        print("Invalid selection, out of stock, or not enough money.")
//    }
//}
//3.转换错误为可选项
/*
 try?通过将错误转换为可选项来处理一个错误。如果一个错误在 try?表达式中抛出，则表达式的值为 nil。
 */
func someThrowingFunction() throws -> Int {
    //...
    throw VendingMachineError.invalidSelection
}
let x = try? someThrowingFunction()

let y: Int?
do {
    y = try someThrowingFunction()
} catch {
    y = nil
}

//
//func fetchData() -> Data? {
//    if let data = try? fetchDataFromDisk() { return data }
//    if let data = try? fetchDataFromServer() { return data }
//    return nil
//}

//4.取消错误传递
/*
 事实上有时你已经知道一个抛出错误或者方法不会在运行时抛出错误。在这种情况下，你可以在表达式前写 try!来取消错误传递并且把调用放进不会有错误抛出的运行时断言当中。
 */

//let photo = try! loadImage("./Resources/John Appleseed.jpg")

//二：指定清理操作
/*
 使用 defer语句来在代码离开当前代码块前执行语句合集。这个语句允许你在以任何方式离开当前代码块前执行必须要的清理工作——无论是因为抛出了错误还是因为 return或者 break这样的语句。比如，你可以使用 defer语句来保证文件描述符都关闭并且手动指定的内存到被释放。
 */
//func processFile(filename: String) throws {
//    if exists(filename) {
//        let file = open(filename)
//        defer {
//            close(file)
//        }
//        while let line = try file.readline() {
//            // Work with the file.
//        }
//        // close(file) is called here, at the end of the scope.
//    }
//}
