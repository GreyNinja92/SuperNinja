//
//  SKWallGenerator.swift
//  Super Ninja
//
//  Created by Saksham Ram Khatod on 30/12/18.
//  Copyright © 2018 Saksham Khatod. All rights reserved.
//

import Foundation
import SpriteKit

class SKWallGenerator : SKSpriteNode {
    
    var generationTimer : Timer?
    var walls = [SKWall]()
    var wallTracker = [SKWall]()
    
    func startGeneratingWallsEvery(seconds : TimeInterval) {
        
        generationTimer = Timer.scheduledTimer(timeInterval: seconds, target: self, selector: #selector(SKWallGenerator.generateWall), userInfo: nil, repeats: true)
        
    }
    
    func stopGenerating() {
        
         generationTimer?.invalidate()
        
    }
    
    @objc func generateWall() {
        
        var scale : CGFloat
        let random = arc4random_uniform(2)
        if random == 0 {
            scale = -1.0
        } else {
            scale = 1.0
        }
        
        let wall = SKWall()
        wall.position.x = size.width/2 + wall.size.width/2
        wall.position.y = scale * (groundHeight/2 + wall.size.height/2)
        walls.append(wall)
        wallTracker.append(wall)
        addChild(wall)
        
    }
    
    func stopWalls() {
        
        stopGenerating()
        
        for wall in walls {
            wall.stopMoving()
        }
        
    }
    
}
