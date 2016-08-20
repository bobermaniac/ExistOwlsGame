//
//  GameScene.swift
//  ExistOwlsGame
//
//  Created by Victor Bryksin on 13/08/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

import SpriteKit
import GameplayKit

class TestScene : SKScene {
    var owl: SKSpriteNode!
    var tinder: SKSpriteNode!
    
    let walkAnimation = SKAction(named: "owl_run_01")!
    let idleAnimation = SKAction(named: "owl_idle_01")!
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        self.backgroundColor = UIColor.white
        
        owl = childNode(withName: "owl") as! SKSpriteNode
        tinder = childNode(withName: "tinder") as! SKSpriteNode
        owl.run(idleAnimation)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: self) else {
            return
        }
        if (location.x < owl.position.x) {
            owl.xScale = -abs(owl.xScale)
        } else {
            owl.xScale = abs(owl.xScale)
        }
        owl.run(walkAnimation)

        let path = SKAction.move(to: location, duration: 3.0)
        owl.run(path, completion: { [unowned self] in self.owl.run(self.idleAnimation) })
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
