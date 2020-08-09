//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

//类型转换

/*
 Swift 中类型转换的实现为 is和as操作符。
 这两个操作符使用了一种简单传神的方式来检查一个值的类型或将某个值转换为另一种类型。
 */

//1.为类型转换定义类层次
class MediaItem {
    var name: String
    init(name: String) {
        self.name = name
    }
}

class Movie: MediaItem {
    var director: String
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}

class Song: MediaItem {
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}

let library = [
    Movie(name: "Casablanca", director: "Michael Curtiz"),
    Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
    Movie(name: "Citizen Kane", director: "Orson Welles"),
    Song(name: "The One And Only", artist: "Chesney Hawkes"),
    Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
]
//Swift 的类型检查器能够推断 Movie 和 Song 有一个共同的父类 MediaItem ，因此 library 的类型推断为 [MediaItem]
// "library" 的类型被推断为[MediaItem]

//为了使用他们原生的类型，你需要检查他们的类型或将他们向下转换为不同的类型


//2.类型检查
/*
 ⚠️
使用类型检查操作符（is）来检查一个实例是否属于一个特定的子类。
如果实例是该子类类型，类型检查操作符返回 true ，否则返回 false 。
 */

var movieCount = 0
var songCount = 0

for item in library {
    if item is Movie {
        movieCount += 1
    } else if item is Song {
        songCount += 1
    }
}
print("Media library contains \(movieCount) movies and \(songCount) songs")


//3.向下类型转换
/*
 某个类类型的常量或变量可能实际上在后台引用自一个子类的实例。
 当你遇到这种情况时你可以尝试使用类型转换操作符（ as? 或 as! ）将它向下类型转换至其子类类型。
 */
/*
 条件形式，as? ，返回了一个你将要向下类型转换的值的可选项。
 强制形式，as! ，则将向下类型转换和强制展开结合为一个步骤。
 */

for item in library {
    if let movie = item as? Movie {
        print("Movie: '\(movie.name)', dir.\(movie.director)")
    } else if let song = item as? Song {
        print("Song: '\(song.name)', dir.\(song.artist)")
    }
}
/*
 Movie: 'Casablanca', dir.Michael Curtiz
 Song: 'Blue Suede Shoes', dir.Elvis Presley
 Movie: 'Citizen Kane', dir.Orson Welles
 Song: 'The One And Only', dir.Chesney Hawkes
 Song: 'Never Gonna Give You Up', dir.Rick Astley
 */

//4.Any 和 AnyObject 的类型转换
/*
 Swift 为不确定的类型提供了两种特殊的类型别名：
 - AnyObject  可以表示任何 类 类型的实例。
 - Any  可以表示任何类型，包括函数类型。
 */
var things = [Any]()

things.append(0)
things.append(0.0)
things.append(42)
things.append(3.14159)
things.append("hello")
things.append((3.0, 5.0))
things.append(Movie(name: "Ghostbusters", director: "Ivan Reitman"))
things.append({ (name: String) -> String in "Hello, \(name)" })

for thing in things {
    switch thing {
    case 0 as Int:
        print("zero as an Int")
    case 0 as Double:
        print("zero as a Double")
    case let someInt as Int:
        print("an integer value of \(someInt)")
    case let someDouble as Double where someDouble > 0:
        print("a positive double value of \(someDouble)")
    case is Double:
        print("some other double value that I don't want to print")
    case let someString as String:
        print("a string value of \"\(someString)\"")
    case let (x, y) as (Double, Double):
        print("an (x, y) point at \(x), \(y)")
    case let movie as Movie:
        print("a movie called \(movie.name), dir. \(movie.director)")
    case let stringConverter as (String) -> String:
        print(stringConverter("Michael"))
    default:
        print("something else")
    }
}
// zero as an Int
// zero as a Double
// an integer value of 42
// a positive double value of 3.14159
// a string value of "hello"
// an (x, y) point at 3.0, 5.0
// a movie called Ghostbusters, dir. Ivan Reitman
// Hello, Michael

/*
 Any类型表示了任意类型的值，包括可选类型。如果你给显式声明的Any类型使用可选项，Swift 就会发出警告。如果你真心需要在Any值中使用可选项，如下所示，你可以使用as运算符来显式地转换可选项为Any。
 */

let optionalNumber: Int? = 3
//things.append(optionalNumber)        // Warning
things.append(optionalNumber as Any) // No warning


//内嵌类型

/*
 枚举通常用于实现特定类或结构体的功能。类似的，它也可以在更加复杂的类型环境中方便的定义通用类和结构体。为实现这种功能，Swift 允许你定义内嵌类型，借此在支持类型的定义中嵌套枚举、类、或结构体。
 若要在一种类型中嵌套另一种类型，在其支持类型的大括号内定义即可。可以根据需求多级嵌套数个类型。
 */
struct BlackjackCard {
    
    //nested Suit enumeration
    enum Suit: Character {
        case spades = "♠", hearts = "♡", diamonds = "♢", clubs = "♣"
    }
    
    //nested Rank enumeration
    enum Rank: Int {
        case two = 2, three, four, five, six, seven, eight, nine, ten
        case jack, queen, king, ace
        struct Values {
            let first: Int, second: Int?
        }
        var values: Values {
            switch self {
            case .ace:
                return Values(first: 1, second: 11)
            case .jack, .queen, .king:
                return Values(first: 10, second: nil)
            default:
                return Values(first: self.rawValue, second: nil)
            }
        }
    }
    
    let rank: Rank, suit: Suit
    var description: String {
        var output = "suit is \(suit.rawValue),"
        output += "value is \(rank.values.first)"
        if let second = rank.values.second {
            output += "or \(second)"
        }
        return output
    }
}
let theAceOfSpades = BlackjackCard(rank: .ace, suit: .spades)
print("theAceOfSpades: \(theAceOfSpades.description)")
//theAceOfSpades: suit is ♠,value is 1or 11

//引用内嵌类型
//要在定义外部使用内嵌类型，只需在其前缀加上内嵌了它的类的类型名

let heartsSymbol = BlackjackCard.Suit.hearts.rawValue
// heartsSymbol is "♡"
