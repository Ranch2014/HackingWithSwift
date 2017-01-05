//
//  ViewController.swift
//  AutoLayout-2
//
//  Created by 焦相如 on 02/01/2017.
//  Copyright © 2017 jaxer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label1 = UILabel()
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.backgroundColor = UIColor.red
        label1.text = "THESE"
        
        let label2 = UILabel()
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.backgroundColor = UIColor.cyan
        label2.text = "ARE"
        
        let label3 = UILabel()
        label3.translatesAutoresizingMaskIntoConstraints = false
        label3.backgroundColor = UIColor.yellow
        label3.text = "SOME"
        
        let label4 = UILabel()
        label4.translatesAutoresizingMaskIntoConstraints = false
        label4.backgroundColor = UIColor.green
        label4.text = "AWESOME"
        
        let label5 = UILabel()
        label5.translatesAutoresizingMaskIntoConstraints = false
        label5.backgroundColor = UIColor.orange
        label5.text = "LABELS"
        
        view.addSubview(label1)
        view.addSubview(label2)
        view.addSubview(label3)
        view.addSubview(label4)
        view.addSubview(label5)
        
        
        //使用VFL
        let viewDictionary = ["label1": label1, "label2": label2, "label3": label3, "label4": label4, "label5": label5]
        
//        view.addConstraint(NSLayoutConstraint.constraints(withVisualFormat: "H:|[label1]|", options: [], metrics: nil, views: viewDictionary)) //⚠️错误的方法（注意方法别混淆）
        
        //水平方向布局（注意Dictionary的遍历方式）
        for label in viewDictionary.keys {
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[\(label)]|", options: [], metrics: nil, views: viewDictionary)) //注意方法别搞混了
        }
        
//        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[label1]-[label2]-[label3]-[label4]-[label5]", options: [], metrics: nil, views: viewDictionary)) //其中 "-" 表示10points
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[label1(==88)]-[label2(==88)]-[label3(==88)]-[label4(==88)]-[label5(==88)]-(>=10)-|", options: [], metrics: nil, views: viewDictionary))
        // >=10 表示距离底边的空间
        
        //使用metrics参数
//        let metrics = ["labelHeight": 88]
//        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[label1(labelHeight)]-[label2(labelHeight)]-[label3(labelHeight)]-[label4(labelHeight)]-[label5(labelHeight)]->=10-|", options: [], metrics: metrics, views: viewDictionary))
        
//        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[label1(labelHeight@999)]-[label2(label1)]-[label3(label1)]-[label4(label1)]-[label5(label1)]->=10-|", options: [], metrics: metrics, views: viewDictionary))
        
        
        //使用自动布局锚点（Auto Layout anchors）
//        var previous: UILabel!
//        
//        for label in [label1, label2, label3, label4, label5] {
//            label.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
//            label.heightAnchor.constraint(equalToConstant: 88).isActive = true
//            
//            if previous != nil {
//                label.topAnchor.constraint(equalTo: previous.bottomAnchor).isActive = true
//            }
//            
//            previous = label
//        }
    }
    
    ///隐藏状态栏
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

