# Project 6: Auto Layout

知识点小结：



- 重写属性

和重写方法类似，本例代码如下：

```swift
//隐藏状态栏(默认是显示的)
override var prefersStatusBarHidden: Bool {
    return true
}
```



- Interface Builder 自动布局


Aspect Ratio：宽高比




- VFL 自动布局

Visual Format Languag：可视化格式语言。



水平方向布局（参数前面使用 `H:`）：

```swift
let viewsDictionary = ["label1": label1, "label2": label2, "label3": label3, "label4": label4, "label5": label5]

//逐条添加约束
view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[label1]|", options: [], metrics: nil, views: viewsDictionary))
//...

//使用循环添加约束（注意Dictionary的遍历方式）
for label in viewDictionary.keys {
	view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[\(label)]|", options: [], metrics: nil, views: viewDictionary)) //注意方法别搞混了
}
```

竖直方向布局（参数前面使用 `V:`）：

```swift
view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[label1]-[label2]-[label3]-[label4]-[label5]", options: [], metrics: nil, views: viewDictionary))
```

PS: 其中 "-" 表示view之间的间隔，默认是10points. 效果如下图所示：

![1](https://github.com/Ranch2014/HackingWithSwift/blob/master/06-Auto%20Layout/mgs/1.png)

若去掉 "-", 则中间的间隔就没了（见末尾图）。



此外，还可以指定高度，例如：

```swift
// ==88 表示label高度，>=10 表示距离底边的空间
// 指定尺寸的时候前后需要加 "-"
view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[label1(==88)]-[label2(==88)]-[label3(==88)]-[label4(==88)]-[label5(==88)]-(>=10)-|", options: [], metrics: nil, views: viewDictionary))
```



但是，这样做在修改时很不方便，需要挨个修改。使用 `metrics` 参数可以方便修改，代码如下：

```swift
//使用metrics参数
let metrics = ["labelHeight": 88]

view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[label1(labelHeight)]-[label2(labelHeight)]-[label3(labelHeight)]-[label4(labelHeight)]-[label5(labelHeight)]->=10-|", options: [], metrics: metrics, views: viewDictionary))
```



自动布局的优先级（*priority*）：1-1000。1000表示是绝对需要（默认是1000）；小于1000则表示可选。

为表示几个label高度相同，代码还可以如下（`@999` 表示指定优先级）：

```swift
//横屏时能正常显示(设置优先级)	没效果？？？
view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[label1(labelHeight@999)]-[label2(label1)]-[label3(label1)]-[label4(label1)]-[label5(label1)]->=10-|", options: [], metrics: metrics, views: viewDictionary))
```



- Auto Layout anchors

自动布局锚点。

> Every `UIView` has a set of anchors that define its layouts rules. The most important ones are `widthAnchor`, `heightAnchor`, `topAnchor`, `bottomAnchor`, `leftAnchor`, `rightAnchor`, `leadingAnchor`, `trailingAnchor`, `centerXAnchor`, and `centerYAnchor`.



Tips: 对于英语等读写从左到右的语言：`leftAnchor` 和  `leadingAnchor` 相同；`rightAnchor` 和 `trailingAnchor` 相同。但对于 Hebrew 和 Arabic 等读写从右至左的语言来说，则恰恰相反。



本例代码：

```swift
var previous: UILabel!

for label in [label1, label2, label3, label4, label5] {
    label.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    label.heightAnchor.constraint(equalToConstant: 88).isActive = true

    if previous != nil {
        // we have a previous label – create a height constraint
        label.topAnchor.constraint(equalTo: previous.bottomAnchor).isActive = true
    }

    // set the previous label to be the current one, for the next loop iteration
    previous = label
}
```

效果如图所示：

![2](https://github.com/Ranch2014/HackingWithSwift/blob/master/06-Auto%20Layout/mgs/2.png)



原文链接：https://www.hackingwithswift.com/read/6