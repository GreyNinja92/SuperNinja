//
//  SKCloudGenerator.swift
//  Super Ninja
//
//  Created by Saksham Ram Khatod on 29/12/18.
//  Copyright © 2018 Saksham Khatod. All rights reserved.
//

import Foundation
import SpriteKit

class SKCloudGenerator : SKSpriteNode {
    
    let cloudWidth = 125.0
    let cloudHeight = 55.0
    var generationTimer : Timer!
    
    func populate(num : Int) {
        
        for i in 0...num {
            let cloud = SKCloud(size: CGSize(width: cloudWidth, height: cloudHeight))
            let x = CGFloat(arc4random_uniform(UInt32(size.width))) - size.width/2
            let y = CGFloat(arc4random_uniform(UInt32(size.height))) - size.height/2
            cloud.position = CGPoint(x: x, y: y)
            cloud.zPosition = -1
            addChild(cloud)
            
        }
        
    }
    
    func startGeneratingWithSpawnTime(seconds: TimeInterval) {
        
        generationTimer = Timer.scheduledTimer(timeInterval: seconds, target: self, selector: #selector(SKCloudGenerator.generateClouds), userInfo: nil, repeats: true)
        
    }
    
    func stopGenerating() {
        
        generationTimer.invalidate()
        
    }
    
    @objc func generateClouds() {
        
        let x = size.width/2 + CGFloat(cloudWidth/2)
        let y = CGFloat(arc4random_uniform(UInt32(size.height))) - size.height/2
        let cloud = SKCloud(size: CGSize(width: cloudWidth, height: cloudHeight))
        cloud.position = CGPoint(x: x, y: y)
        cloud.zPosition = -1
        addChild(cloud)
        
    }
    
    
}
