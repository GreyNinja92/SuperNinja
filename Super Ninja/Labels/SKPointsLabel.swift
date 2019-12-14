//
//  SKPointsLabel.swift
//  Super Ninja
//
//  Created by Saksham Ram Khatod on 01/01/19.
//  Copyright © 2019 Saksham Khatod. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class SKPointsLabel : SKLabelNode {
    
    var number = 0
    
    init(num: Int) {
        
        super.init()
        
        fontColor = UIColor.black
        fontName = "Helvetica"
        fontSize = 24.0
        
        number = num
        text = "\(num)"
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func increment() {
        
        number += 1
        text = "\(number)"
        
    }
    
    func setTo(num: Int) {
        
        number = num
        text = "\(number)"
        
    }
    
}
