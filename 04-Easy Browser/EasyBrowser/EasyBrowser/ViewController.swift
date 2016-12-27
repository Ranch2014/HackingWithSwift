//
//  ViewController.swift
//  EasyBrowser
//
//  Created by 焦相如 on 21/12/2016.
//  Copyright © 2016 jaxer. All rights reserved.
//

import UIKit
import WebKit

//WKNavigationDelegate 为该类遵守的协议
class ViewController: UIViewController, WKNavigationDelegate {

    var websites = ["apple.com", "hackingwithswift.com"]
    var webView: WKWebView!
    var progressView: UIProgressView!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://" + websites[0])!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        
        //进度条
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        
        //添加工具栏item
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        toolbarItems = [progressButton, spacer, refresh]
        navigationController?.isToolbarHidden = false //显示工具栏
        
        //添加KVO
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    }
    
    //一旦使用了KVO，必须重写该方法
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress) //后者是Double类型，前者是Float类型
        }
    }
    
    func openTapped() {
        let ac = UIAlertController(title: "Open page...", message: nil, preferredStyle: .actionSheet)
        
//        ac.addAction(UIAlertAction(title: "apple.com", style: .default, handler: openPage))
//        ac.addAction(UIAlertAction(title: "hackingwithswift.com", style: .default, handler: openPage))
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        for website in websites {
//            print(website)
            ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage)) //闭包
        }
        
//        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }

    func openPage(action: UIAlertAction!) {
        let url = URL(string: "https://" + action.title!)! //构建URL
        webView.load(URLRequest(url: url))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title //在导航栏显示网页标题
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        
        if let host = url!.host { //解包可选型变量
            for website in websites {
                if host.range(of: website) != nil { //??
                    print(host.range(of: website) ?? "Nil") //判断website是否存在相应的域名中（注意range(of:)用法），这样貌似也有问题：缺少某些字母时判断已然成立
//                    print("hello".range(of: "he") ?? "No")
                    decisionHandler(.allow)
                    return
                }
            }
        }
        
        decisionHandler(.cancel)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

