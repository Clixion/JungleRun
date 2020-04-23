//
//  CreateJoinScene.swift
//  JungleRun
//
//  Created by Felix Kylie on 23/04/20.
//  Copyright © 2020 Felix Kylie. All rights reserved.
//

import SpriteKit

class CreateJoinScene: SKScene {
    
     var createButton = SKSpriteNode()
     var joinButton = SKSpriteNode()
     
     override func didMove(to view: SKView) {
         initialize()
     }
     
     func initialize() {
         getButtons()
     }
     
     override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
         
         for touch in touches {
             
             let location = touch.location(in: self)
             
             if atPoint(location) == createButton {
                 
             }
             
             if atPoint(location) == joinButton {
                 
             }
             
         }
         
     }
     
     func getButtons() {
         createButton = self.childNode(withName: "playNode") as! SKSpriteNode
         joinButton = self.childNode(withName: "highScoreNode") as! SKSpriteNode
     }
    
}
