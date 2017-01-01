//
//  ViewController.swift
//  WordScramble
//
//  Created by 焦相如 on 28/12/2016.
//  Copyright © 2016 jaxer. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UITableViewController {

    var allWords = [String]() //保存文本中的所有单词
    var usedWords = [String]() //保存用到的单词
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        
        //读取项目资源中的 start.txt 文件
        if let startWordsPath = Bundle.main.path(forResource: "start", ofType: ".txt") {
//            print(startWordsPath)
            if let startWords = try? String(contentsOfFile: startWordsPath) {
//                print(startWords) //文件中的所有内容
                allWords = startWords.components(separatedBy: "\n") //以换行符分隔字符串，并赋给数组allWords
            }
        } else {
            allWords = ["silkworm"] //读取文件失败的默认值
        }
        
        startGame()
        
//        let num = 1 as Float
        let vi: UIView = UIView()
//        let table1: UITableView = UITableView()
        print(vi as? UITableView)
//        print(vi as? NSObject)
        
    }
    
    func promptForAnswer() {
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        ac.addTextField() //添加一个TextField
        
        //The in keyword is important: everything before that describes the closure; everything after that is the closure. So (action: UIAlertAction!) in means that it accepts one parameter in, of type UIAlertAction.
        //[unowned self, ac] 表示将self和ac改为弱引用。unowned与weak效果相同
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned self, ac] (action: UIAlertAction!) in
            let answer = ac.textFields![0]
            self.submit(answer: answer.text!) //声明self为弱引用后，再调用方法时前面需要加self
        }
        
        ac.addAction(submitAction) //action表示点击后的动作，可添加多个
//        ac.addAction(UIAlertAction(title: "test", style: .default, handler: nil)) //for test
        
        present(ac, animated: true)
    }

    //判断新词是否都用原8字符单词组成
    func isPossible(word: String) -> Bool {
        var tempWord = title!.lowercased()
        
        //遍历word中的每个字母，若包含在8字母单词中，
        for letter in word.characters {
            //range(of:) returns an optional position of where the item was found(it might be nil)
            if let pos = tempWord.range(of: String(letter)) { //range(of:)方法参数为String类型，因此需要强转
                print(pos)
                tempWord.remove(at: pos.lowerBound) //??
            } else {
                return false
            }
        }
        
        return true
    }
    
    ///判断某个词是否使用过
    func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word) //是否包含
    }
    
    //判断能否组成一个词
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSMakeRange(0, word.utf16.count) //??utf16
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en") //该方法返回一个NSRange类型的结构体，告诉拼写错误的位置
        print("location-->%d", misspelledRange.location) //返回的位置是从哪开始？若由错误返回0，无错误返回一个很大的数？
        return misspelledRange.location == NSNotFound
//        return true
    }
    
    func submit(answer: String) {
        let lowerAnswer = answer.lowercased()
        
        let errorTitle: String
        let errorMessage: String
        
        if isPossible(word: lowerAnswer) {
            if isOriginal(word: lowerAnswer) {
                if isReal(word: lowerAnswer) {
                    usedWords.insert(answer, at: 0)
                    
                    let indexPath = IndexPath(row: 0, section: 0)
                    tableView.insertRows(at: [indexPath], with: .automatic) //即UITableViewRowAnimation.automatic
                    
                    return
                } else {
                    errorTitle = "Word not recognised"
                    errorMessage = "You can't just make them up, you know!"
                }
            } else {
                errorTitle = "Word used already"
                errorMessage = "Be more original!"
            }
        } else {
            errorTitle = "Word not possible"
            errorMessage = "You can't spell that word from '\(title!.lowercased())'!"
        }
        
        let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func startGame() {
        allWords = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: allWords) as! [String] //随机化数组
        title = allWords[0]
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

