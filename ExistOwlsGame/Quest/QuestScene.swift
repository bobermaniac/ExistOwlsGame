//
//  QuestScene.swift
//  ExistOwlsGame
//
//  Created by Victor Bryksin on 20/08/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

import SpriteKit

enum QuestSceneEvent {
    case pcMoveToPoint(CGPoint)
    case pcMoveToSprite(SKSpriteNode)
}

protocol QuestSceneEvents {
    func eventHandled(_ event: QuestSceneEvent)
}

protocol QuestSceneActors {
    var PC : SKSpriteNode { get }
    
    var mainCamera : SKCameraNode { get }
}

class QuestScene : SKScene {
    // MARK: Public interface
    /**
     Callback object to notify quest scene events
    */
    var events : QuestSceneEvents? = nil
    /**
     Protocol to manage scene actors
    */
    var actors : QuestSceneActors? = nil
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.count == 1 {
            _handleSingleTouch(touches.first!)
        }
    }
    

    // MARK: Private variables
    // MARK: Private methods
    
    private func _handleSingleTouch(_ touch: UITouch) {
        let location = touch.location(in: self)
        if let spriteUnderTouch = self.nodes(at: location).first as? SKSpriteNode {
            self.events?.eventHandled(.pcMoveToSprite(spriteUnderTouch))
        }
        self.events?.eventHandled(.pcMoveToPoint(touch.location(in: self)))
    }
}
