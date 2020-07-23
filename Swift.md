# Swift

## 基础内容

### 常量&变量

- 常量：let
- 变量：var
- 类型标注

	- 主动告知
	- 赋值

- 非法名称

	- 空白字符
	- 数学符号
	- 箭头
	- 保留Unicode码位
	- 连线
	- 制表符

- print(_:separator:terminator)

	- 输出不带换行符print(someValue,terminator:"")

- 字符串插值 \()

### 注释

- 单行注释：//
- 多行注释：/* */
- 多行注释内嵌：
/*
/**/
*/ 

### 分号

- 单行一句代码可以不写分号
- 单行多句代码需加分号

### 整数

- 类型

	- 有符号
	- 无符号

- 整数范围

	- min
	- max
	- eg:UInt8.max,UInt8.min

- Int:拥有与当前平台的原生字相同的长度
- UInt

### 浮点数

- Double:64位的浮点数，精度有15位，推荐使用
- Float:32位的浮点数，精度只有6位

### 类型安全和类型推断

- Swift在推断浮点值的时候始终会选择Double

### 数值型字面量

- 整数型字面量

	- 十进制：无前缀
	- 二进制：0b
	- 八进制：0o
	- 十六进制：0x

- 浮点字面量

	- 十进制

		- e：基数为10

	- 十六进制

		- p：基数为2

- 可添加额外的0或者下划线来增加代码的可读性：let a = 000123.456   let b = 1_000_000

### 数值类型转换

- 整数转换

	- 转换方法 someType(ofInitalValue)
	- Int8:-128~127
	- UInt8:0~255

- 整数和浮点数转换

	- 整数和浮点数类型的转换必须显示地指定类型
	- 在用浮点数初始化为一个新的整数类型的时候，数值会被截断

### 类型别名

- typealias

	- eg:typealias AudioSample = UInt6

### 布尔值

- true
- false

### 元组

- 把多个值合并为单一的复合型的值。元组内的值可以是任何类型的，类型不同的值。
- 访问方式 

	- 1.分解 let（a, b）= (1,2) -> a=1 b=2

	  let http404Error = (404, "Not Found")
	  let (statusCode, statusMessage) = http404Error
	  print("The status code is \(statusCode)")
	  // prints "The status code is 404"
	  print("The status message is \(statusMessage)")
	  // prints "The status message is Not Found"

	- 2.从0开是的索引   let a=(1,2)   a.0 = 1, a.1= 2
	- 3. 命名  let c= (a:1,b:2)   c.a = 1 c.b = 2

### 可选项

- 这里有一个值，它等于x  
或者
这里根本没有值

	- eg： 可选的Int 不是Int  是 Int?  ,  它要么是Int要么什么都没有。

	  let possibleNumber = "123"
	  let convertedNumber = Int(possibleNumber)
	  print(convertedNumber) //会报错 需要提供一个默认值
	  print(convertedNumber ?? 3) 如果convertedNumber是nil，则输出3 ，如果是Int 输出123

- nil:值缺失的一种特殊类型
- if语句以及强制展开:if语句可以通过nil来判断一个可选项中是否包含值。

	- 相等运算符 ==
	- 不等运算符 !=  
	- 可选值的强制展开：确定可选项中有值， 可以在可选项的名字后面加一个！来获取值。   

- 可选项绑定

	- 单个可选项绑定

	  if let constantName = someOptional {
	  
	  }

	- 多个可选项绑定

	  if let firstNumber = Int("4"), let secondNumber = Int("42"), firstNumber < secondNumber && secondNumber < 100 {
	    print("\(firstNumber) < \(secondNumber) < 100")
	  }
	  
	  只要有一个是nil，则if内的不会执行

- 隐式展开可选项:主要用于类的初始化过程

	- let assumedString: String! = "An inplicitly unwrapped optional string"

### 错误处理

- throws

	- do{
     try  func()
}catch{
}

### 断言和先决条件

- 使用断言进行调试

	- assert(_:_:)
	- assertionFailure(_:file:line:)

- 强制先决条件

	- precondition(_:_:file:line:)
	- preconditionFailure(_:file:line:)

## 基本运算符

### 赋值运算符

- 赋值运算符并不会返回值
- let (x,y) = (1,2)

### 算术运算符：swift的运算符默认不允许值溢出

- 标准算术运算符

	- +

		- 也支持连接字符串

	- -
	- *
	- /

- 余数运算符

	- a = (b x some multiplier) + remainder

- 一元减号运算符 - 取相反数
- 一元加号运算符 + 不做任何处理，直接返回原值

### 组合运算符

- 由赋值符号（ = ）和其他符号组成的 组合赋值符号 。eg +=

### 比较运算符

- ==
- !=
- >
- <
- >=
- <=
- 元组（含有多个值，但是得小于7个）也可以比较，但是元组里不能包含布尔值

### 三元条件运算符    a ? b : c

### 合并空值运算符  ??

合并空值运算符 （ a ?? b ）如果可选项 a  有值则展开，如果没有值，是 nil  ，则返回默认值 b 。表达式 a 必须是一个可选类型。表达式 b  必须与 a  的储存类型相同。

### 区间运算符

- 闭区间运算符  ...
- 半开区间运算符  ..<
- 单侧区间 [...number] [..<number]

  检测单侧区间是否包含特定的值
  contains
  let range = ...5
  range.contains(7)   // false
  range.contains(4)   // true
  range.contains(-1)  // true

### 逻辑运算符

- ||
- &&
- !
- 混合逻辑运算
- 显示括号

## 字符串和字符

### 字符串字面量

- 单行字符串 “ ”
- 多行字符串 “”“   ”“”

	- 阻止换行 末尾加反斜杠 \
	- 某行的空格超过了结束的双引号（ """ ），那么这些空格会被包含
	- 多行字符串字面量起始或结束于换行，就在第一或最后一行写一个空行

- 特殊字符

	- 转义字符

		- 空字符：\0
		- 反斜杠：\\
		- 水平制表符：\t
		- 换行符：\n
		- 回车符：\r
		- 双引号：\"
		- 单引号：\'

	- 任意的Unicode标量

		- \u{n}

- 扩展字符串分隔符

	- #  放置在\ 和 转义字符之间

### 初始化一个空字符串

- var longString = ""
- var longString = String()

### 字符串可变性

- let
- var

### 字符串是值类型

- 只会在需要用时才拷贝

### 操作字符串

- for-in 遍历
- 通过Character字符来初始化字符串

### 连接字符串和字符

- +
- +=
- append()  

  只能给一个 String变量的末尾追加 Character(可以是多个字符)值
  不能把 String或者 Character追加到已经存在的 Character变量当中，因为 Character值能且只能包含一个字符

### 字符串插值 \()

### Unicode标量

- 扩展字形集群

### 字符统计 count

Swift 为 Character值使用的扩展字形集群意味着字符串的创建和修改可能不会总是影响字符串的字符统计数。

eg:
var word = "cafe" //cafe
print("the number of characters in \(word) is \(word.count)")  //4

word.append("\u{301}")    //café

print("the number of characters in \(word) is \(word.count)") //4 

扩展字形集群能够组合一个或者多个 Unicode 标量。这意味着不同的字符——以及相同字符的不同表示——能够获得不同大小的内存来储存。因此，Swift 中的字符并不会在字符串中获得相同的内存空间。所以说，字符串中字符的数量如果不遍历它的扩展字形集群边界的话，是不能被计算出来的。如果你在操作特殊的长字符串值，要注意 count属性为了确定字符串中的字符要遍历整个字符串的 Unicode 标量。
通过 count属性返回的字符统计并不会总是与包含相同字符的 NSString中 length属性相同。 NSString中的长度是基于在字符串的 UTF-16 表示中16位码元的数量来表示的，而不是字符串中 Unicode 扩展字形集群的数量。

### 访问和修改字符串

- 字符串索引

	- String.index()

	  返回每个 Character在字符串中的位置
	  
	  你可以在任何遵循了 Indexable 协议的类型中使用 startIndex 和 endIndex 属性以及 index(before:) ， index(after:) 和 index(_:offsetBy:) 方法。这包括这里使用的 String ，还有集合类型比如 Array ， Dictionary 和 Set 。

		- index(before:)
		- index(after:)
		- index(_:offsetBy:)

	- startIndex
	- endIndex
	- 子主题 4

- 插入和删除

  你可以在任何遵循了 RangeReplaceableIndexable 协议的类型中使用 insert(_:at:) ， insert(contentsOf:at:) ， remove(at:) 方法。这包括了这里使用的 String ，同样还有集合类型比如 Array ， Dictionary 和 Set 。

	- 插入

		- 插入单个字符：insert(_:at:)
		- 插入字符串： insert(contentsOf:at:

	- 删除

		- 删除单个字符：remove(at:),

		  返回被删除的字符

		- 删除某个范围内的字符串：removeSubrange(_:)   

		  参数 Range<String.Index>

### 子字符串

子字符串不是一个新的字符串，它只是subString（subString 和 string 无差别）的实例。也就是说它重用了字符串的一些内存。
与字符串类似，每一个子字符串都有一块内存区域用来保存组成子字符串的字符。字符串与子字符串的不同之处在于，作为性能上的优化，子字符串可以重用一部分用来保存原字符串的内存，或者是用来保存其他子字符串的内存。（字符串也拥有类似的优化，但是如果两个字符串使用相同的内存，他们就是等价的。）这个性能优化意味着在你修改字符串或者子字符串之前都不需要花费拷贝内存的代价。如同上面所说的，子字符串并不适合长期保存——因为它们重用了原字符串的内存，只要这个字符串有子字符串在使用中，那么这个字符串就必须一直保存在内存里。那么就需要把子字符串转换为 String 实例

### 字符串比较

- 字符串和字符相等性

  两个 String值（或者两个 Character值）如果它们的扩展字形集群是规范化相等，则被认为是相等的。如果扩展字形集群拥有相同的语言意义和外形，我们就说它规范化相等，就算它们实际上是由不同的 Unicode 标量组合而成。

	- ==
	- !=

- 前缀、后缀相等性

  本质：比较字符串和字符相等性

	- hasPrefix(_:)
	- hasSuffix(_:)

### 字符串的Unicode表示法

- Utf-8
- Utf-16
- Unicode标量表示法

## 集合类型

集合的可变性
在集合不需要改变的情况下创建不可变集合是个不错的选择。这样做可以允许 Swift 编译器优化你创建的集合的性能。

### 数组

有序的值的集合

以有序的方式储存相同类型的值
相同类型的值可以数组中多次出现

- 写法

	- 完整：Array<Element>
	- 简写：[Element]

- 创建一个空数组

	- var someInts = [Int]()

- 使用默认值创建数组

	- var threeDoubles = Array(repeating:0.0,count:3)

- +：合并两个同类型的数组为一个新数组
- 使用字面量创建数组

	- var someStrs:[String] = ["a", "b", "c"]

- 访问和修改数组

	- count:数组元素数量
	- 检查数组元素数量为0

		- someStrs.isEmpty

	- 是否包含某个元素

		- contains()

	- 数组添加元素

		- append

		  可添加一个或多个元素

		- +=：添加一个或多个同类型元素

	- 通过下标（从0开始）访问数组或修改已存在的值。一次性修改多个someStrs[1...3] = ["d","f"]
	- insert(_:at:)：指定位置插入元素 
	- remove(at:):移除指定位置的元素
	- removeAll():清空数组
	- removeLast():最后一个元素开始移除Int个元素，默认为1个
	- removeFirst(Int):从第一个元素开始移除Int个元素,默认为1个

- 遍历一个数组

	- for-in
	- enumerated()

	  enumerated()获取每一个元素的元组，分解得到索引
	  for (index,item) in someStrs2.enumerated(){
	    print(index,item)
	  }

### 集合

同一类型且不重复的值无序地储存在一个集合

- 哈希值

  储存在集合中的值类型都必须是有哈希值的
  哈希值是Int值且所有的对比起来相等的对象都相同

- Set<Element>
- 创建一个空集合

	- var nullSet = Set<Element>()

- 插入元素

	- insert()

- 置空集合

	- 使用空数组字面量 nullSet = []

- 使用数组字面量初始化一个集合

	- var favoriteGenres: Set<String> =  ["Rock", "Classical", "Hip hop"]


- 访问和修改集合

	- count:集合元素数量
	- isEmpty:集合是否为空
	- insert(_:)
	- remove(_:)
	- removeAll()
	- contains(_:)

- 遍历集合

	- for-in

		- sorted()

		  Swift 的 Set类型是无序的。要以特定的顺序遍历合集的值，使用 sorted()方法，它把合集的元素作为使用 < 运算符排序了的数组返回

- 执行集合操作

	- intersection(_:)

	  交集：创建一个只包含两个合集共有值的新合集

	- symmetricDifference(_:)

	  差集：创建一个只包含两个合集各自有的非共有值的新合集

	- union(_:)

	  合集：创建一个包含两个合集所有值的新合集

	- subtracting(_:)

	  创建一个两个合集当中不包含某个合集值的新合集

- 集合比较

	- ==

	  使用“相等”运算符 ( == )来判断两个合集是否包含完全相同的值；

	- isSubset(of:)

	  确定一个合集的所有值是被某合集包含

	- isStrictSubset(of:)

	  来确定是个合集是否为某一个合集的子集，但并不相等

	- isSuperset(of:)

	  确定一个合集是否包含某个合集的所有值

	-  isStrictSuperset(of:)

	  来确定是个合集是否为某一个合集的超集，但并不相等

	- isDisjoint(with:)

### 字典

无序的键值对集合

字典储存无序的互相关联的同一类型的键和同一类型的值的集合。

- Dictionary<key,value>
- 创建空字典

	- var namesOfIntegers = [Int:String]()

- 置空字典

	- namesOfIntegers = [:]

- 用字典字面量创建字典

	- var airports:[String:String] = ["a":"a","b":"b","c":"c"]

- 访问和修改字典

	- count：字典有几个元素
	- isEmpty:字典是否为空
	- 使用键名下标添加或修改、访问键值

	  由于可能请求的键没有值，字典的下标脚本返回可选的字典值类型。如果字典包含了请求的键的值，下标脚本就返回一个包含这个键的值的可选项。否则，下标脚本返回 nil
	  
	  可以使用下标脚本语法给一个键赋值 nil来从字典当中移除一个键值对

	- updateValue(_:forKey:)：修改键值

	  方法返回一个字典值类型的可选项值。比如对于储存 String值的字典来说，方法会返回 String?类型的值，或者说“可选的 String”。这个可选项包含了键的旧值如果更新前存在的话，否则就是 nil：

	- removeValue(forKey:)

- 遍历字典

	- for-in

		- keys
		- values

*XMind - Trial Version*