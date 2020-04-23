//
//  SingleMultiScene.swift
//  JungleRun
//
//  Created by Felix Kylie on 23/04/20.
//  Copyright © 2020 Felix Kylie. All rights reserved.
//

import SpriteKit

class SingleMultiScene: SKScene {
    
    var singleButton = SKSpriteNode()
    var multiButton = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        initialize()
    }
    
    func initialize() {
        getButtons()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            
            let location = touch.location(in: self)
            
            if atPoint(location) == singleButton {
                let gamePlay = GameplayScene(fileNamed: "GameplayScene")
                gamePlay?.scaleMode = .aspectFill
                self.view?.presentScene(gamePlay!, transition: SKTransition.fade(withDuration: 1.5))
                print("Goal")
            }
            
            if atPoint(location) == multiButton {
                let createJoin = CreateJoinScene(fileNamed: "CreateJoinScene")
                createJoin?.scaleMode = .aspectFill
                self.view?.presentScene(createJoin!, transition: SKTransition.fade(withDuration: 1.5))
                print("Goal")
            }
            
        }
        
    }
    
    func getButtons() {
        singleButton = self.childNode(withName: "playNode") as! SKSpriteNode
        multiButton = self.childNode(withName: "highScoreNode") as! SKSpriteNode
    }
    
}
