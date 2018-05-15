//
//  ViewController.swift
//  Game
//
//  Created by EthanLin on 2018/5/15.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //處理時間到了以後alert重複Present的問題
    var alertPresentedForCountDown:Bool = false
    //倒數計時
    var timer:Timer?
    var counter = 5{
        didSet{
            self.timeLabel.text = "時間:\(counter)秒"
        }
    }
    //時間
    @IBOutlet weak var timeLabel: UILabel!
    
    //分數表
    @IBOutlet weak var scoreLabel: UILabel!
    
    let arrowArray = ["blueUp","blueDown","blueRight","blueLeft"]
    var direction:String = ""
    var totalScore:Int = 0{
        didSet{
            self.scoreLabel.text = "分數:\(totalScore)分"
        }
    }
    
    //自訂方法
    func rule(direction:String){
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.imageView.frame.origin.x = self.imageView.frame.origin.x - 50
            self.imageView.alpha = CGFloat(0.0)
            
        }, completion: nil)
        if self.direction == direction{
            self.totalScore += 20
        }
        self.direction = self.arrowArray[Int(arc4random_uniform(UInt32(self.arrowArray.count)))]
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
            self.imageView.frame.origin.x = self.imageView.frame.origin.x + 50           
            self.imageView.alpha = CGFloat(1.0)
        }, completion: nil)
        
        self.imageView.image = UIImage(named: self.direction)
        
        print(self.direction)
    }

    @IBAction func reset(_ sender: UIButton) {
        let alert = UIAlertController(title: "遊戲將重新開始", message: "按下確定後重新開始", preferredStyle: .alert)
        let action = UIAlertAction(title: "確定", style: .default) { (action) in
            self.totalScore = 0
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
            //按下確定後要再把alertPresetForCountDown改成false
            self.alertPresentedForCountDown = false
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func swipeRight(_ sender: UISwipeGestureRecognizer) {
        rule(direction: "blueRight")
    }
    
    @IBAction func swipeUp(_ sender: UISwipeGestureRecognizer) {
        rule(direction: "blueUp")
    }
    
    @IBAction func swipeLeft(_ sender: UISwipeGestureRecognizer) {
        rule(direction: "blueLeft")
    }
    
    @IBAction func swipeDown(_ sender: UISwipeGestureRecognizer) {
        rule(direction: "blueDown")
    }
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    //倒數計時方法
    @objc func countDown(){
        if self.counter > 0{
            counter -= 1
        }else{
            if self.alertPresentedForCountDown == false{
                let alert = UIAlertController(title: "時間到", message: "遊戲結束，您的得分為\(self.totalScore)", preferredStyle: .alert)
                let action = UIAlertAction(title: "確定", style: .default) { (action) in
                    self.timer?.invalidate()
                    self.counter = 5
                }
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
                //Present完以後把alertPreseted改成已經出現
                self.alertPresentedForCountDown = true
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let alert = UIAlertController(title: "遊戲開始", message: "按下確定後遊戲開始", preferredStyle: .alert)
        let action = UIAlertAction(title: "確定", style: .default) { (action) in
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
        self.direction = self.arrowArray[Int(arc4random_uniform(UInt32(self.arrowArray.count)))]
        self.imageView.image = UIImage(named: self.direction)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

