//
//  GameVC.swift
//  Game
//
//  Created by Peichun Tsai on 2018/5/15.
//  Copyright © 2018年 Peichun Tsai. All rights reserved.
//

import UIKit

class GameVC: UIViewController {

    
    @IBOutlet weak var gamblingChipsImage: UIImageView!
    @IBOutlet weak var bankerCardImage: UIImageView!
    @IBOutlet weak var readyPlaceImage: UIImageView!
    
    @IBOutlet weak var gamerChipsLabel: UILabel!
    
    var gamerChips = 100
    var cardList = [1,2,3,4,5,6,7,8,9,10,11,12,13]
//    var playerCardList = [1,2,3,4,5,6,7,8,9,10,11,12,13]
    var clubCardList = ["c1","c2","c3","c4","c5","c6","c7","c8","c9","c10","c11","c12","c13"]
    var heartCardList =  ["h1","h2","h3","h4","h5","h6","h7","h8","h9","h10","h11","h12","h13"]
    
    var bankerCard: Int!
    

    
    @IBAction func dealBtn(_ sender: Any) {
        print("Starting deal cards.")
        dealCard()
//        print(bankerCard!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        gamerChipsLabel.text = "\(gamerChips)"
//        
//        if gamerChips <= 100 {
//            gamblingChipsImage.image = UIImage(named: "icons8-chip")
//        }
//        else if gamerChips > 100 {
//            gamblingChipsImage.image = UIImage(named: "icons8-roulette_chips")
//        }
////        else if gamerChips == 0 {
////            gamblingChipsImage.image = UIImage(named: "icons8-chip")
////        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



    func dealCard() {
        
        print(cardList)
        bankerCard = Int(arc4random_uniform(UInt32(cardList.count)))
        print(bankerCard!)
        bankerCardImage.image = UIImage(named: "card_front0")
        
        
        //發牌動畫
        UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations: {
            // Here you will get the animation you want
            self.bankerCardImage.center = self.readyPlaceImage.center
            self.bankerCardImage.transform = CGAffineTransform(scaleX: 2, y: 3.5)
            
        }, completion: { _ in
            // Here you hide it when animation done
            self.bankerCardImage.isHidden = true
        })
        
        
        readyPlaceImage.image = UIImage(named: "c\(self.bankerCard + 1)")
        
        //翻牌動畫
        //這裡時間要比上面曼，否則在按下發牌機後會和上面同時出現
        UIView.transition(with: self.readyPlaceImage, duration: 2, options: .transitionFlipFromRight, animations: {
            self.bankerCardImage.alpha = 1
        }, completion: nil)
        
        cardList.remove(at: bankerCard)

        print(cardList)
        if cardList == [] {
            print("Game Set")
        }
    }

}
