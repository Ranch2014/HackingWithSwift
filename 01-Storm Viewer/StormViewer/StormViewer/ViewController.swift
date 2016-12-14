//
//  ViewController.swift
//  StormViewer
//
//  Created by 焦相如 on 07/12/2016.
//  Copyright © 2016 jaxer. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var pictures = [String]() //[String] means “an array of strings”, and () means “create one now.”
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        title = "Storm Viewer"
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath! //a bundle is a directory containing our compiled program and all our assets.
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
            print("item--" + item)
        }
        
//        print(pictures)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row] //textLabel? 若有则赋值，否则为nil
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

