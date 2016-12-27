# Project 4: Easy Browser

知识点小结：



- 类和结构体的区别
  - 类可以继承，结构体不能；
  - 方法中作为参数时，结构体传的是值，类传的是引用。



- 闭包

  - closure

  一段代码块，可以像传递变量一样传递给一个函数，以后会执行。

  - *escaping* closure (???)

立即调用，或者过段时间再调用，使用关键字 `@escaping` 。还是不太理解……下面是《Hacking With Swift》的解释：

> Because you might call the `decisionHandler` closure straight away, or you might call it later on (perhaps after asking the user what they want to do), Swift considers it to be an *escaping* closure. That is, the closure has the potential to escape the current method, and be used at a later date. We won’t be using it that way, but it has the *potential* and that’s what matters.

本例代码：

```swift
func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        
        if let host = url!.host { //解包可选型变量
            for website in websites {
                if host.range(of: website) != nil {
                    decisionHandler(.allow)
                    return
                }
            }
        }
        
        decisionHandler(.cancel)
    }
```



- 网络请求

调用网络请求方面的类，需要引入 `WebKit` , 通常需要实现 `WKNavigationDelegate` 协议，示例代码：

```swift
	var webView: WKWebView!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self //设置代理，作用？？
        view = webView
    }
```



创建网络请求，示例代码：

```swift
let url = URL(string: "https://www.hackingwithswift.com")! //注意https
webView.load(URLRequest(url: url))
webView.allowsBackForwardNavigationGestures = true
```

注意：苹果要求使用 `https` 。URL必须是完整的。



- 另一种弹窗

Project介绍了一种弹窗，这里又出现了另一种模式的弹窗，如图所示：

![1](https://www.hackingwithswift.com/img/hws/4-2.png)

实现代码：

```swift
let ac = UIAlertController(title: "Open page...", message: nil, preferredStyle: .actionSheet) //弹窗标题
ac.addAction(UIAlertAction(title: "apple.com", style: .default, handler: openPage)) //添加弹窗item1
ac.addAction(UIAlertAction(title: "hackingwithswift.com", style: .default, handler: openPage)) //添加弹窗item2
ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
present(ac, animated: true)
```



- KVO


KVO, 即键值观察（key-value observing），用于检测某个属性变化。本例中的代码：


```swift
webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil) //添加KVO，监测estimatedProgress

//一旦使用了KVO，必须重写该方法
override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
	if keyPath == "estimatedProgress" {
		progressView.progress = Float(webView.estimatedProgress) //后者是Double类型，前者是Float类型
	}
}
```



- 工具栏

```swift
//进度条
var progressView: UIProgressView!

progressView = UIProgressView(progressViewStyle: .default)
progressView.sizeToFit()
let progressButton = UIBarButtonItem(customView: progressView) //包装UIProgressView, 以便添加到工具栏


//添加工具栏的item
let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
toolbarItems = [progressButton, spacer, refresh] //工具栏的items
navigationController?.isToolbarHidden = false //显示工具栏
```



- 其他问题

闭包问题，closure, escaping closure ??



原文链接：https://www.hackingwithswift.com/read/4