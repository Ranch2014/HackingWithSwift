# Project 1: Storm Viewer

知识点小结：



- 方法重写

使用 `override` 关键字和 `func` 关键字，例如：

```swift
override func viewDidLoad() {
	super.viewDidLoad()
}
```



- 显示/隐藏导航栏

`ViewController` 可以通过点击屏幕来显示或隐藏导航栏，示例代码：

```swift
navigationController?.hidesBarsOnTap = true //单击屏幕来显示/隐藏导航栏
```



- 文件系统

```swift
let fm = FileManager.default //查找文件
let path = Bundle.main.resourcePath! //a bundle is a directory containing our compiled program and all our assets. 即获取资源的路径
let items = try! fm.contentsOfDirectory(atPath: path)	
```

表示读取项目中的资源。



try! 关键字：表示下面的代码可能会出错，但现在保证它不出错。



path 打印的路径示例：

`~/Library/Developer/CoreSimulator/Devices/48778D4A-9C6E-4A0A-A472-C10A258EA557/data/Containers/Bundle/Application/65851E39-5119-42FA-A751-DB2C66701066/StormViewer.app`



- 其他小知识点

定义数组，示例代码：

```swift
var pictures = [String]()
```

 `[String]` means “an array of strings”, and `()` means “create one now.”



- 注意事项

点击 cell 跳转时可能会遇到卡顿的问题，解决方案：设置下DetailViewController的背景色，例如：

```swift
view.backgroundColor = UIColor.black
```





https://www.hackingwithswift.com/read/1/overview