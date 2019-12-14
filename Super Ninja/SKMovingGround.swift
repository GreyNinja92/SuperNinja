//
//  SKMovingGround.swift
//  Super Ninja
//
//  Created by Saksham Ram Khatod on 20/12/18.
//  Copyright © 2018 Saksham Khatod. All rights reserved.
//

import Foundation
import SpriteKit

class SKMovingGround: SKSpriteNode {
    
    let numberOfSegments = 20
    let colorOne = UIColor(red: 88.0/255.0, green: 148.0/255.0, blue: 87.0/255.0, alpha: 1.0)
    let colorTwo = UIColor(red: 120.0/255.0, green: 195.0/255.0, blue: 118.0/255.0, alpha: 1.0)
    
    init(size: CGSize) {
        super.init(texture: nil, color: UIColor.brown, size: CGSize(width: size.width*2, height: size.height))
        anchorPoint = CGPoint(x: 0, y: 0.5)
        
        for i in 0...numberOfSegments {
            
            var segmentColor: UIColor!
            if i % 2 == 0 {
                segmentColor = colorOne
            } else {
                segmentColor = colorTwo
            }
            
            let segment = SKSpriteNode(color: segmentColor, size: CGSize(width: self.size.width/CGFloat(numberOfSegments), height: self.size.height))
            segment.anchorPoint = CGPoint(x: 0.0, y: 0.5)
            segment.position = CGPoint(x: CGFloat(i)*segment.size.width, y: 0)
            addChild(segment)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func start() {
        
        let adjustedDuration = TimeInterval(frame.size.width / defaultXToMovePerSecond)
        
        let moveLeft = SKAction.moveBy(x: -frame.size.width/2, y: 0, duration: adjustedDuration/2)
        let resetPosition = SKAction.moveTo(x: 0, duration: 0)
        
        let moveSequence = SKAction.sequence([moveLeft, resetPosition])
        
        run(SKAction.repeatForever(moveSequence))
    }
    
    func stop() {
        
        removeAllActions()
        
    }
}
