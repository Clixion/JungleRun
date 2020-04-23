//
//  MainMenuScene.swift
//  JungleRun
//
//  Created by Felix Kylie on 23/04/20.
//  Copyright © 2020 Felix Kylie. All rights reserved.
//

import SpriteKit

class MainMenuScene: SKScene {
    
    var playButton = SKSpriteNode()
    var highScoreButton = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        initialize()
    }
    
    func initialize() {
        getButtons()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            
            let location = touch.location(in: self)
            
            if atPoint(location) == playButton {
                let gamePlay = SingleMultiScene(fileNamed: "SingleMultiScene")
                gamePlay?.scaleMode = .aspectFill
                self.view?.presentScene(gamePlay!, transition: SKTransition.fade(withDuration: 1.5))
                print("Goal")
            }
            
            if atPoint(location) == highScoreButton {
                //Show high score
            }
            
        }
        
    }
    
    func getButtons() {
        playButton = self.childNode(withName: "playNode") as! SKSpriteNode
        highScoreButton = self.childNode(withName: "highScoreNode") as! SKSpriteNode
    }
    
    
}
