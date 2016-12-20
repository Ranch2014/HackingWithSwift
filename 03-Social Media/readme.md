# Project 3: Social Media

知识点小结：



- 导航栏添加按钮

示例代码：

```swift
navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped)) //注意 #selector 写法
```



- UIActivityViewController

创建分享页面：

```swift
let vc = UIActivityViewController(activityItems: [imageView.image!], applicationActivities: [])
vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
present(vc, animated: true)
```

示意图：

![1](https://www.hackingwithswift.com/img/hws/3-1.png)



- 自带分享组件



添加

```swift
import Social
```

类似于引入 `import UIKit` 



添加分享内容：

```swift
if let vc = SLComposeViewController(forServiceType: SLServiceTypeFacebook) {
    vc.setInitialText("Look at this great picture!")
    vc.add(imageView.image!)
    vc.add(URL(string: "http://www.photolib.noaa.gov/nssl"))
    present(vc, animated: true)
}
```

示意图：

![2](https://www.hackingwithswift.com/img/hws/3-2.png)





原文链接：https://www.hackingwithswift.com/read/3