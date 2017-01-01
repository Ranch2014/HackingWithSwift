# Project 5: Word Scramble

知识点小结：



- 读取项目资源

本例代码如下：

```swift
//读取项目资源中的 start.txt 文件
if let startWordsPath = Bundle.main.path(forResource: "start", ofType: ".txt") {
	//...
}

//本例打印 startWordsPath 为: ~/Library/Developer/CoreSimulator/Devices/4..7/data/Containers/Bundle/Application/0..F/WordScramble.app/start.txt
```

PS: `path(forResource:)` 方法返回的是 `String?` 类型，因此需要解包。



- try?

表示：调用后面的语句，若出现错误，则返回 `nil`. 使用时需要进行解包。

本例代码：

```swift
if let startWords = try? String(contentsOfFile: startWordsPath) {
	allWords = startWords.components(separatedBy: "\n")
}
```



- as 关键字

该关键字表示对象的类型转换。有三种写法：即 `as`, `as!` 和 `as?`

​	as: 意为"有保证的转换（**Guaranteed conversion**）"，即向上转换，也就是将子类对象转为父类的类型。

​	as? 和 as!: 其中 `as!` 表示强制转换；`as?` 表示尝试转换，若转换失败则返回 `nil` 。



示例代码如下：

```swift
//as 还可以将字面量指定类型，例如：
let num = 1 as Float


class Animal {}
class Dog: Animal {}

let a: Animal = Dog()
//向下转换(父类转子类)
a as Dog		// now raises the error:  "'Animal is not convertible to 'Dog';
				// ... did you mean to use 'as!' to force downcast?"
//强制向下转换(报错)
a as! Dog		// forced downcast is allowed 

a as? Dog		//这样语法没问题，返回 nil

//向上转换(子类转父类)
let d = Dog()
d as Animal		// upcast succeeds
```

参考：

官方文档：https://developer.apple.com/swift/blog/?id=23



- *trailing closure*

trailing closure，结尾闭包。

[Project 2](https://github.com/Ranch2014/HackingWithSwift/tree/master/02-Guess%20the%20Flag) 的代码涉及到了闭包，如下所示：

```swift
UIAlertAction(title: "Continue", style: .default, handler: askQuestion)
```

而闭包实际上是一个代码块，有点像匿名函数。因此，从语法上讲，可以写成下面的形式：

```swift
UIAlertAction(title: "Continue", style: .default, handler: { *CLOSURE CODE HERE* })
```



但是，若这样写，若后面的 `CLOSURE CODE HERE` 比较多，代码难看。`Swift` 使用 结尾闭包（`trailing closure`）来解决这个问题。

使用条件：当闭包作为函数的最后一个参数时。

其代码风格如下：

```swift
UIAlertAction(title: "Continue", style: .default) {
    CLOSURE CODE HERE
}
```

这样写代码看起来更美观。



- 关键字 in



> The `in` keyword is important: everything before that describes the closure; everything after that *is* the closure. So `(action: UIAlertAction!) in` means that it accepts one parameter in, of type `UIAlertAction`.
>
> 关键字 `in` 很重要：它之前的所有代码是对闭包的描述；它之后是闭包。因此`(action: UIAlertAction!) in` 表示该方法接收一个 `UIAlertAction` 类型的参数。



本例代码：

```swift
let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned self, ac] (action: UIAlertAction!) in
	//...
}
```

`Swift` 知道这是一个什么样的闭包，因此我们可以将

```swift
(action: UIAlertAction!) in
```

简化为：

```swift
action in
```

还可以继续简化（因为本例并未使用参数 `action`）：

```swift
_ in
```



- 弱引用

闭包的使用和 block 类似，为防止出现"循环引用"问题，需要对闭包中使用的对象弱化。block 中使用 `weak` 关键字，这里可以使用关键字 `weak` 和 `unowned`。

本例代码：

```swift
let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned self, ac] (action: UIAlertAction!) in
	let answer = ac.textFields![0]
	self.submit(answer: answer.text!) //注意：声明self为弱引用后，再调用对象方法时前面需要加self
}
```



- UItextChecker

`UItextChecker` 类的 `rangeOfMisspelledWord(in:)` 方法可用于检测一个字符单词是否拼写错误，本例代码如下：

```swift
func isReal(word: String) -> Bool {
    let checker = UITextChecker()
    let range = NSMakeRange(0, word.utf16.count) //参数分别为起始位置和长度，返回NSRange类型
    let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en") //该方法返回一个NSRange类型的结构体，告诉拼写错误的位置

    return misspelledRange.location == NSNotFound
}
```



`utf16.count` 和 `characters.count` 的使用规则（不太理解）：

> when you’re working with UIKit, SpriteKit, or any other Apple framework, use `utf16.count` for the character count. If it’s just your own code - i.e. looping over characters and processing each one individually – then use `characters.count` instead.





原文链接：https://www.hackingwithswift.com/read/5/overview