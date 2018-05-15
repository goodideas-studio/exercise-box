//  ViewController.swift
//  Ells_game
//
//  Created by 唐嘉伶 on 2018/5/15.
//  Copyright © 2018 唐嘉伶. All rights reserved.

import UIKit

class ViewController: UIViewController {

  enum direction: Int {
    case up
    case down
    case left
    case right
  }
  
  
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet weak var numberLabel: UILabel!
  
  @IBOutlet weak var newNumBtn: UIButton!
  @IBOutlet weak var resetBtn: UIButton!
  
  @IBOutlet weak var enterNumTextFd: UITextField!
  @IBOutlet weak var sentResultBtn: UIButton!
  @IBOutlet weak var numContrainerView: UIView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func generateRandomNum() -> Int {
    var returnNum = arc4random_uniform(9999)
    return Int(returnNum)
  }
  
  func generateDirection() {
    arc4random_uniform(<#T##__upper_bound: UInt32##UInt32#>)
  }
  
  func generateAnimation() {
    
  }
  
  
  @IBAction func askNewNum(_ sender: UIButton) {
    generateRandomNum()
    generateDirection()
    generateAnimation()
  }
  
  @IBAction func resetGame(_ sender: UIButton) {
    scoreLabel.text = String(0)
    
  }
  
  @IBAction func sentResult(_ sender: UIButton) {
    
  }
}

