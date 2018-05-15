//
//  UIButton.swift
//  HitTheHole
//
//  Created by PinguMac on 2018/5/15.
//  Copyright © 2018年 PinguMac. All rights reserved.
//

import UIKit

extension UIButton {
  func shake() {
    let shakeAnimate = CABasicAnimation(keyPath: "Position")
    shakeAnimate.duration = 0.2
    shakeAnimate.repeatDuration = 20
    shakeAnimate.autoreverses = true
    
    let fromPoint = CGPoint(x: center.x - 15, y: center.y)
    let fromValue = NSValue(cgPoint: fromPoint)
    
    let toPoint = CGPoint(x: center.x + 15, y: center.y)
    let toValue = NSValue(cgPoint: toPoint)
    
    shakeAnimate.fromValue = fromValue
    shakeAnimate.toValue = toValue
    
    layer.add(shakeAnimate, forKey: nil)
  }
}
