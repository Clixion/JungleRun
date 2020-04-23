//
//  GameplayScene.swift
//  JungleRun
//
//  Created by Felix Kylie on 19/04/20.
//  Copyright © 2020 Felix Kylie. All rights reserved.
//

import SpriteKit

class GameplayScene: SKScene, SKPhysicsContactDelegate {
    
    var player = Player()
    
    var obstacles = [SKSpriteNode]()
    var fruits = [SKSpriteNode]()
    var isAlive = true
    var score = 0
    var scoreLabel = SKLabelNode()
    var scoreCal = 0
    var cal = 0
    var calLabel = SKLabelNode()
    var counterScore = Timer()
    var counterObstacle = Timer()
    var counterFruit = Timer()
    var timer = 0
    var fastSlow = Timer()
    var backgroundTimer = Timer()
    
    override func didMove(to view: SKView) {
        initialize()
    }
    
    func initialize() {
        
        physicsWorld.contactDelegate = self
        
        createTree()
        createBackground()
        createPlayer()
        createObstacle()
        createFruit()
        getLabel()
        
        fastSlow = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GameplayScene.timerFastSlow), userInfo: nil, repeats: true)
        counterScore = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GameplayScene.incrementScore), userInfo: nil, repeats: true)
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        if (isAlive) {
            moveBackgroundAndTrees()
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            
            
            if (location.x < 0 && player.position.x > -50) {
                player.goLeft()
            } else if (location.x > 0 && player.position.x < 50) {
                player.goRight()
            }
        }
    }
    
    func getLabel() {
        scoreLabel = self.childNode(withName: "scoreValueLabel") as! SKLabelNode
        scoreLabel.text = "0"
        calLabel = self.childNode(withName: "calValueLabel") as! SKLabelNode
        calLabel.text = "0"
    }
    
    @objc func incrementScore() {
        score = score + 1
        scoreLabel.text = "\(score)"
        scoreCal = scoreCal + 1
        timer = scoreCal
        if scoreCal % 8 == 0 {
            cal = scoreCal / 8
            calLabel.text = "\(cal)"
        }
    }
    
    @objc func timerFastSlow() {
        //Diatas 1 menit
        if timer > 60 {
            timer = timer % 60
            if timer >= 45 {
                //cepet
                if timer % 3 == 0 {
                    spawnFruits()
                } else if timer % 1 == 0 {
                    spawnObstacles()
                }
            } else {
                //lambat
                if timer % 5 == 0 {
                    spawnFruits()
                } else if timer % 3 == 0 {
                    spawnObstacles()
                }
            }
        }   //Dibawah 1 menit
        else {
            if timer >= 45 {
                //cepetin
                if timer % 3 == 0 {
                    spawnFruits()
                } else if timer % 1 == 0 {
                    spawnObstacles()
                }
            } else {
                //lambat
                if timer % 5 == 0 {
                    spawnFruits()
                } else if timer % 3 == 0 {
                    spawnObstacles()
                }
            }
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody = SKPhysicsBody()
        var secondBody = SKPhysicsBody()
        
        if contact.bodyA.node?.name == "Player" {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if firstBody.node?.name == "Player" && secondBody.node?.name == "Obstacle" {
            //Game Over Code
            playerDied()
        }
        
        if firstBody.node?.name == "Player" && secondBody.node?.name == "Fruit" {
            //Eat + Point
            score += 5
            secondBody.node?.removeFromParent()
        }
        
    }
    
    func createPlayer() {
        player = Player.init(color: .clear, size: CGSize(width: 150, height: 288))
        player.initialize()
        player.position = CGPoint(x: 0, y: -640)
        self.addChild(player)
    }
    
    func createBackground() {
        for i in 0...2 {
            let background = SKSpriteNode(imageNamed: "background")
            background.name = "Background"
            background.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            background.position = CGPoint(x: 0, y: CGFloat(i) * background.size.height)
            background.zPosition = 0
            addChild(background)
        }
    }
    
    func createTree(){
        for i in 0...2 {
            let tree = SKSpriteNode(imageNamed: "trees")
            tree.name = "Tree"
            tree.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            tree.position = CGPoint(x: 0, y: CGFloat(i) * tree.size.height)
            tree.zPosition = 4
            addChild(tree)
        }
    }
    
    func moveBackgroundAndTrees() {
        //Background
        enumerateChildNodes(withName: "Background") { (node, error) in
            
            let backgroundNode = node as! SKSpriteNode
            
            backgroundNode.position.y -= 15
            
            if node.position.y < -(self.frame.height) {
                //3 because 3 background from range 0...2
                node.position.y += self.frame.height * 3
            }
        }
        
        //Tree
        enumerateChildNodes(withName: "Tree") { (node, error) in
            
            let backgroundNode = node as! SKSpriteNode
            
            backgroundNode.position.y -= 15
            
            if node.position.y < -(self.frame.height) {
                node.position.y += self.frame.height * 3
            }
        }
    }
    
    func createObstacle() {
        
        for i in 1...2 {
            let obstacle = SKSpriteNode(imageNamed: "Obstacle_\(i)")
            
            if i == 1 {
                obstacle.size = CGSize(width: 200, height: 112)
            } else if i == 2 {
                obstacle.size = CGSize(width: 200, height: 84)
            }
            
            obstacle.name = "Obstacle"
            obstacle.zPosition = 3
            obstacle.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            obstacle.physicsBody = SKPhysicsBody(rectangleOf: obstacle.size)
            obstacle.physicsBody?.allowsRotation = false
            obstacle.physicsBody?.restitution = 0
            obstacle.physicsBody?.categoryBitMask = ColliderType.Obstacle
            obstacle.physicsBody?.collisionBitMask = ColliderType.Player
            obstacle.physicsBody?.contactTestBitMask = ColliderType.Player
            obstacle.physicsBody?.isDynamic = false
            obstacle.physicsBody?.affectedByGravity = false
            obstacles.append(obstacle)
        }
    }
    
    func createFruit() {
        let fruit = SKSpriteNode(imageNamed: "Fruit")
        fruit.size = CGSize(width: 100, height: 124)
        fruit.name = "Fruit"
        fruit.color = .green
        fruit.zPosition = 3
        fruit.physicsBody = SKPhysicsBody(rectangleOf: fruit.size)
        fruit.physicsBody?.allowsRotation = false
        fruit.physicsBody?.restitution = 0
        fruit.physicsBody?.categoryBitMask = ColliderType.Fruit
        fruit.physicsBody?.contactTestBitMask = ColliderType.Player
        fruit.physicsBody?.isDynamic = false
        fruit.physicsBody?.affectedByGravity = false
        fruits.append(fruit)
    }
    
    func spawnObstacles() {
        let index = Int(arc4random_uniform(UInt32(obstacles.count)));
        let obstacle = obstacles[index].copy() as! SKSpriteNode
        let randomX = CGFloat.random(in: -200 ... 200)
        obstacle.position = CGPoint(x: CGFloat(randomX) , y: self.frame.height + obstacle.size.height)
        let move = SKAction.moveTo(y: -(self.frame.size.height), duration: TimeInterval(5))
        let remove = SKAction.removeFromParent()
        let sequence = SKAction.sequence([move, remove])
        obstacle.run(sequence)
        addChild(obstacle)
    }
    
    func spawnFruits() {
        let fruit = fruits[0].copy() as! SKSpriteNode
        let randomX = CGFloat.random(in: -180 ... 180)
        fruit.position = CGPoint(x: CGFloat(randomX) , y: self.frame.height)
        let move = SKAction.moveTo(y: -(self.frame.size.height), duration: TimeInterval(5))
        let remove = SKAction.removeFromParent()
        let sequence = SKAction.sequence([move, remove])
        fruit.run(sequence)
        addChild(fruit)
    }
    
    func playerDied() {
        isAlive = false
        player.removeFromParent()
        counterScore.invalidate()
        counterFruit.invalidate()
        counterObstacle.invalidate()
        fastSlow.invalidate()
        backgroundTimer.invalidate()
    }
}
