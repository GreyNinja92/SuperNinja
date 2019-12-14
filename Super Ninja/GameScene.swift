//
//  GameScene.swift
//  Super Ninja
//
//  Created by Saksham Ram Khatod on 20/12/18.
//  Copyright © 2018 Saksham Khatod. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var movingGround : SKMovingGround!
    var hero : SKHero!
    var cloudGenerator : SKCloudGenerator!
    var wallGenerator : SKWallGenerator!
    
    var isStarted = false
    var isGameOver = false
    
    var currentLevel = 0
    
    override func didMove(to view: SKView) {
        
        backgroundColor = UIColor(red: 159.0/255.0, green: 201.0/255.0, blue: 244.0/255.0, alpha: 1.0)
        
        addMovingGround()
        addHero()
        addCloudGenerator()
        addWallGenerator()
        addTapToStartLabel()
        addPointsLabels()
        addPhysicsWorld()
        loadHighscore()
        
        }
    
    func addMovingGround() {
        
        movingGround = SKMovingGround(size: CGSize(width: view!.frame.width, height: groundHeight))
        movingGround.position = CGPoint(x: 0, y: view!.frame.size.height/2)
        addChild(movingGround)
        
    }
    
    func addHero() {
        
        hero = SKHero()
        hero.position = CGPoint(x: 70, y: movingGround.position.y + movingGround.frame.size.height/2 + hero.frame.size.height/2)
        addChild(hero)
        hero.breath()
        
    }
    
    func addCloudGenerator() {
        
        cloudGenerator = SKCloudGenerator(color: UIColor.clear, size: view!.frame.size)
        cloudGenerator.position = view!.center
        addChild(cloudGenerator)
        cloudGenerator.populate(num: 7)
        cloudGenerator.startGeneratingWithSpawnTime(seconds: 5)
        
    }
    
    func addWallGenerator() {
        
        wallGenerator = SKWallGenerator(color: UIColor.clear, size: view!.frame.size)
        wallGenerator.position = view!.center
        addChild(wallGenerator)
        
    }
    
    func addTapToStartLabel() {
        
        let taptoStartLabel = SKLabelNode(text: "Tap to Start!")
        taptoStartLabel.name = "tapToStartLabel"
        taptoStartLabel.position.x = view!.center.x
        taptoStartLabel.position.y = view!.center.y + 40
        taptoStartLabel.fontName = "Helvetica"
        taptoStartLabel.fontColor = UIColor.black
        taptoStartLabel.fontSize = 22.0
        addChild(taptoStartLabel)
        taptoStartLabel.run(blinkAnimation())
        
    }
    
    func addPointsLabels() {
        
        let pointsLabel = SKPointsLabel(num: 0)
        pointsLabel.position = CGPoint(x: 20.0, y: view!.frame.size.height - 35)
        pointsLabel.name = "pointsLabel"
        addChild(pointsLabel)
        
        let highScoreLabel = SKPointsLabel(num: 0)
        highScoreLabel.position = CGPoint(x: view!.frame.size.width - 20, y: view!.frame.size.height - 35)
        highScoreLabel.name = "highScoreLabel"
        addChild(highScoreLabel)
        
        let highScoreTextLabel = SKLabelNode(text: "Highscore")
        highScoreTextLabel.fontColor = UIColor.black
        highScoreTextLabel.fontSize = 14.0
        highScoreTextLabel.fontName = "Helvetica"
        highScoreTextLabel.position = CGPoint(x: -15, y: -20)
        highScoreLabel.addChild(highScoreTextLabel)
    }
    
    func addPhysicsWorld() {
        
        physicsWorld.contactDelegate = self
        
    }
    
    func loadHighscore() {
        
        let defaults = UserDefaults.standard
        let highScoreLabel = childNode(withName: "highScoreLabel") as! SKPointsLabel
        highScoreLabel.setTo(num: defaults.integer(forKey: "highscore"))
        
    }
    
    func start() {
        
        let taptoStartLabel = childNode(withName: "tapToStartLabel")
        taptoStartLabel?.removeFromParent()
        
        isStarted = true
        hero.stop()
        hero.startRunning()
        movingGround.start()
        wallGenerator.startGeneratingWallsEvery(seconds: 1)
        
    }
    
    func restart() {
        
        cloudGenerator.stopGenerating()
        
        let newScene = GameScene(size: view!.bounds.size)
        newScene.scaleMode = .aspectFill
        
        view!.presentScene(newScene)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if isGameOver {
            restart()
        } else if !isStarted {
            start()
        } else {
            hero.flip()
        }
        
    }
    
    func gameOver() {
        
        isGameOver = true
        
        //Stop Everything
        hero.fall()
        wallGenerator.stopWalls()
        movingGround.stop()
        hero.stop()
        
        //Game Over Label
        let gameOverLabel = SKLabelNode(text: "Game Over!")
        gameOverLabel.fontColor = UIColor.black
        gameOverLabel.fontName = "Helvetica"
        gameOverLabel.position.x = view!.center.x
        gameOverLabel.position.y = view!.center.y + 40
        gameOverLabel.fontSize = 22.0
        addChild(gameOverLabel)
        gameOverLabel.run(blinkAnimation())
        
        //Save Current Points Label Value
        let pointsLabel = childNode(withName: "pointsLabel") as! SKPointsLabel
        let highScoreLabel = childNode(withName: "highScoreLabel") as! SKPointsLabel
        
        if highScoreLabel.number < pointsLabel.number {
            highScoreLabel.setTo(num: pointsLabel.number)
            
            let defaults = UserDefaults.standard
            defaults.set(highScoreLabel.number, forKey: "highscore")
            
        }
        
    }
    
    //SKPhysicsContactDelegate
    func didBegin(_ contact: SKPhysicsContact) {
        
        if !isGameOver {
        gameOver()
        }
        
    }
    
    //Animations
    func blinkAnimation() -> SKAction {
        
        let duration = 0.4
        let fadeOut = SKAction.fadeAlpha(to: 0.0, duration: duration)
        let fadeIn = SKAction.fadeAlpha(to: 1.0, duration: duration)
        let blink = SKAction.sequence([fadeOut, fadeIn])
        
        return SKAction.repeatForever(blink)
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        if wallGenerator.wallTracker.count > 0 {
        
            let wall = wallGenerator.wallTracker[0] as SKWall
            
            let wallLocation = wallGenerator.convert(wall.position, to: self)
            if wallLocation.x < hero.position.x {
                wallGenerator.wallTracker.remove(at: 0)
                
                let pointsLabel = childNode(withName: "pointsLabel") as! SKPointsLabel
                pointsLabel.increment()
                
                if currentLevel <= 5 {
                    if pointsLabel.number % kNumberOfPointsPerLevel == 0 {
                        currentLevel += 1
                        wallGenerator.stopGenerating()
                        wallGenerator.startGeneratingWallsEvery(seconds: kLevelGenerationTimes[currentLevel])
                    }
                }
            }
        }
    }
    
}
