//
//  ViewController.swift
//  HitTheHole
//
//  Created by PinguMac on 2018/5/15.
//  Copyright © 2018年 PinguMac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  // MARK: - Properties
  @IBOutlet weak var illustrateView: UIView!
  
  @IBOutlet weak var dice1ImageView: UIImageView!
  @IBOutlet weak var dice2ImageView: UIImageView!
  @IBOutlet weak var moneyLabel: UILabel!
  @IBOutlet weak var startButton: UIButton!
  @IBOutlet weak var bigBet: UITextField!
  @IBOutlet weak var smallBet: UITextField!
  @IBOutlet weak var errorLabel: UILabel!
  
  private lazy var dice1AnimatedImages: [UIImage] = [UIImage]()
  private lazy var dice2AnimatedImages: [UIImage] = [UIImage]()
  
  private var isTapStart: Bool = false
  private var defaultMoney: Int = 5000
  private var totalMoney: Int = 0
  
  private enum Dice: Int {
    case dice1
    case dice2
  }
  
  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    totalMoney = defaultMoney
    moneyLabel.text = String(totalMoney)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Arctions
  @IBAction func didTapExistIllustrateButton(_ sender: UIButton) {
    illustrateView.isHidden = true
  }
  
  @IBAction func didTapStartButton(_ sender: UIButton) {
    if isTapStart {
      isTapStart = !isTapStart
      startButton.setImage(UIImage(named: "Go.png"), for: UIControlState.normal)
      
      let dice1Number = Int(arc4random_uniform(UInt32(6)) + 1)
      dice1ImageView.image = UIImage(named: "dice\(dice1Number).png")
      dice1ImageView.stopAnimating()
      
      let dice2Number = Int(arc4random_uniform(UInt32(6)) + 1)
      dice2ImageView.image = UIImage(named: "dice\(dice2Number).png")
      dice2ImageView.stopAnimating()
      
      let totalDiceNumber = dice1Number + dice2Number
      settlement(totalDiceNumber)
    } else {
      guard totalMoney > 0 else {
        sender.shake()
        errorLabel.isHidden = false
        errorLabel.text = "No Enough Money."
        return
      }
      
      resignBetMoney()
      
      if Int(bigBet.text!)! > totalMoney || Int(smallBet.text!)! > totalMoney {
        sender.shake()
        errorLabel.isHidden = false
        errorLabel.text = "Bet Money Exceeded Remain Money."
        return
      }
      
      errorLabel.isHidden = true
      isTapStart = !isTapStart
      startButton.setImage(UIImage(named: "Cancel.png"), for: UIControlState.normal)
      
      // Create Image Animation Image for Image View
      createAnimationImage(Dice.dice1.rawValue, isReset: false)
      createAnimationImage(Dice.dice2.rawValue, isReset: false)
      
      dice1ImageView.startAnimating()
      dice2ImageView.startAnimating()
    }
  }
  
  @IBAction func didTapResetButton(_ sender: Any) {
    errorLabel.isHidden = true
    moneyLabel.text = String(defaultMoney)
    
    bigBet.text = ""
    smallBet.text = ""
    
    createAnimationImage(Dice.dice1.rawValue, isReset: true)
    createAnimationImage(Dice.dice2.rawValue, isReset: true)
  }
  
  // MARK: - Help Method
  private func createAnimationImage(_ diceNumber: Int, isReset: Bool) {
    if isReset {
      dice1ImageView.image = UIImage(named: "dice1.png")
      dice2ImageView.image = UIImage(named: "dice1.png")
    } else {
      for photoIndes in 1...6 {
        let imageName = "dice\(photoIndes).png"
        
        switch diceNumber {
        case Dice.dice1.rawValue:
          dice1AnimatedImages.append(UIImage(named: imageName)!)
          dice1ImageView.animationImages = dice1AnimatedImages
          dice1ImageView.animationDuration = 0.3
        default:
          dice2AnimatedImages.append(UIImage(named: imageName)!)
          dice2ImageView.animationImages = dice2AnimatedImages
          dice2ImageView.animationDuration = 0.5
        }
      }
    }
  }
  
  private func settlement(_ diceNumber: Int) {
    if diceNumber < 7 {
      totalMoney += Int(smallBet.text!)! - Int(bigBet.text!)!
    } else {
      totalMoney += Int(bigBet.text!)! - Int(smallBet.text!)!
    }
    moneyLabel.text = String(totalMoney)
  }
  
  private func resignBetMoney() {
    if smallBet.text == "" {
      smallBet.text = "0"
    }
    
    if bigBet.text == "" {
      bigBet.text = "0"
    }
  }
}

