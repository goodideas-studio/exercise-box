//
//  ViewController.swift
//  sonny
//
//  Created by Sonny on 2018/5/15.
//  Copyright © 2018年 Sonny. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    var isplaying = false
    var seconds:Int = 0
    var score:Int = 0
    var myRandom = Int(arc4random_uniform(4))
    var timer = Timer()
    var cellTrueArray = [false,false,false,false]
    var cellImageArray = ["hulk","deadpool","batman","ironman"]
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var myCollectionViewFlowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var resetDisplay: UIButton!
    
    @IBAction func startBtn(_ sender: UIButton) {
        
        
        print("startBtn press")
        if isplaying == false {
            runTimer()
            isplaying = true
        }
        
    }
    
    @IBAction func resetBtn(_ sender: UIButton) {
        timer.invalidate()
        score = 0
        seconds = 0
        scoreLabel.text = "\(score)"
        timeLabel.text = "\(seconds)"
        isplaying = false
        cellTrueArray = [false,false,false,false]
        print(seconds)

    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        resetDisplay.titleLabel?.textColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        timeLabel.text = "\(seconds)"
        
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! myCollectionViewCell
        cell.cellImage.image = UIImage(named: cellImageArray[indexPath.row])
        cell.cellImage.isHidden = true
        
        
        switch indexPath.row {
        case 0 :
            
            cell.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
            if  cellTrueArray[indexPath.row] == true {
                cell.cellImage.isHidden = false
            }
        case 1 :
            cell.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
            if  cellTrueArray[indexPath.row] == true {
                cell.cellImage.isHidden = false
            }
        case 2 :
            cell.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            if  cellTrueArray[indexPath.row] == true {
                cell.cellImage.isHidden = false
            }
        default :
            cell.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            if  cellTrueArray[indexPath.row] == true {
                cell.cellImage.isHidden = false
            }
           
        }
        
        return cell
    }
    
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
//    {
//        var frame  = self.view.frame;
//        var width = frame.width
//        width = CGFloat(width/2)
//        return CGSize(width: width, height: 200)
//        
//    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
       
        
        if score == 0 {
            resetDisplay.titleLabel?.textColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        }else {
            resetDisplay.titleLabel?.textColor  = #colorLiteral(red: 0.5527273417, green: 0.5872040987, blue: 1, alpha: 1)
        }
        
        if cellTrueArray[indexPath.row] {
            score += 50
            scoreLabel.text = "\(score)"
            print("Hit Me \(score) times")
        }
        
    }
 
    override func viewWillLayoutSubviews() {
        scoreLabel.text = "\(score)"
        self.myCollectionViewFlowLayout.itemSize.width = (self.view.frame.width) / 2 - 1
        self.myCollectionViewFlowLayout.itemSize.height = (self.view.frame.height) / 2 - 20
        
        if score == 0 {
            resetDisplay.titleLabel?.textColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
            
        }else {
            resetDisplay.titleLabel?.textColor  = #colorLiteral(red: 0.5527273417, green: 0.5872040987, blue: 1, alpha: 1)
            
        }
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
    }

    @objc func updateTimer() {
        randomCell()
        //This will decrement(count down)the seconds.
        seconds += 1
        //update time label.
        timeLabel.text = "\(seconds)"
        print(seconds)
        myCollectionView.reloadData()
    }
    
    func randomCell() {
        let myRandom = Int(arc4random_uniform(4))
        cellTrueArray = [false,false,false,false]
        cellTrueArray[myRandom] = true
        print(cellTrueArray)
    }
    
    
    
    
    
    
    
}

