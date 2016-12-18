# Project 2: Guess the Flag

知识点小结：



- 字符串数组

```swift
var countries = [String]() //定义一个字符串数组
countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"] //添加
```



- 随机数

`GameplayKit` 中产生随机数的方法：

```swift
GKRandomSource.sharedRandom().arrayByShufflingObjects(in: countries) as! [String] //随机化数组 countries

GKRandomSource.sharedRandom().nextInt(upperBound: 3) //在[0,3)中选一个随机数，即0，1，或2
```



- 弹窗



```swift
let ac = UIAlertController(title: title, message: "Your score is \(score).", preferredStyle: .alert)
ac.addAction(UIAlertAction(title: "Coutinue", style: .default, handler: askQuestion))
present(ac, animated: true)
```

其中 "Correct" 是 `UIAlertController` 的 `title`, 而 "Continue" 是 `UIAlertAction` 的 `title`,  `askQuestion` 是点击 ”Continue“ 时调用的方法。如图所示：

![1](https://github.com/Ranch2014/HackingWithSwift/blob/master/02-Guess%20the%20Flag/pics/pic1.png)

> 注意：这里应该写 `askQuestion` 而不是 `askQuestion()`。

> 前者表示“askQuestion 就是将要运行的方法的名字”；而后者表示“立即运行 askQuestion() 方法，该方法返回将要运行的方法名（也就是通过 askQuestion() 方法返回方法名，好像有点绕……）”



- 其他问题

Q：自动布局为何宽度由为200变为254？？？

如图所示：

![2](https://github.com/Ranch2014/HackingWithSwift/blob/master/02-Guess%20the%20Flag/pics/pic2.png)





原文链接：https://www.hackingwithswift.com/read/2