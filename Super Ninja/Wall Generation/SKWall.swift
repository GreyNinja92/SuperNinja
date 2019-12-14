//
//  SKWall.swift
//  Super Ninja
//
//  Created by Saksham Ram Khatod on 30/12/18.
//  Copyright © 2018 Saksham Khatod. All rights reserved.
//

import Foundation
import SpriteKit

class SKWall : SKSpriteNode {
    
    let wallWidth : CGFloat = 30.0
    let wallHeight : CGFloat = 50.0
    let wallColor = UIColor.black
    
    init() {
        
        let size = CGSize(width: wallWidth, height: wallHeight)
        
        super.init(texture: nil, color: wallColor, size: size)
        
        loadPhysicsBodyWithSize(size: size)
        startMoving()
        
    }
    
    func loadPhysicsBodyWithSize(size: CGSize) {
        
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.categoryBitMask = wallCategory
        physicsBody?.affectedByGravity = false
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startMoving() {
        
        let moveLeft = SKAction.moveBy(x: -defaultXToMovePerSecond, y: 0, duration: 1)
        run(SKAction.repeatForever(moveLeft))
        
    }
    
    func stopMoving() {
        
        removeAllActions()
        
    }
    
}
