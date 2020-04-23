//
//  Player.swift
//  JungleRun
//
//  Created by Felix Kylie on 19/04/20.
//  Copyright © 2020 Felix Kylie. All rights reserved.
//

import SpriteKit

struct ColliderType {
    static let Player: UInt32 = 1
    static let Obstacle: UInt32 = 2
    static let Fruit: UInt32 = 3
}

class Player: SKSpriteNode {
    
    func initialize() {
        
        var jog = [SKTexture]();
        
        for i in 1...2 {
            let name = "Player1_\(i)";
            jog.append(SKTexture(imageNamed: name));
        }
        
        let jogAnimation = SKAction.animate(with: jog, timePerFrame: TimeInterval(0.3), resize: true, restore: true);
        
        self.name = "Player"
        self.zPosition = 2
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.restitution = 0
        self.physicsBody?.categoryBitMask = ColliderType.Player
        self.physicsBody?.collisionBitMask = ColliderType.Obstacle
        self.physicsBody?.contactTestBitMask = ColliderType.Fruit
        
        self.run(SKAction.repeatForever(jogAnimation));
    }
    
    func goLeft() {
        self.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        let moveLeft = SKAction.moveBy(x: -(190), y: 0, duration: 0.3)
        self.run(moveLeft)
    }
    
    func goRight() {
        self.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        let moveRight = SKAction.moveBy(x: (190), y: 0, duration: 0.3)
        self.run(moveRight)
    }
    
}
