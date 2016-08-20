//
//  ExampleQuestScene.swift
//  ExistOwlsGame
//
//  Created by Victor Bryksin on 20/08/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

import SpriteKit

class ExampleTextureBatch {
    let PCSheet : SKETextureSheet
    let PCAnimation : AnimationSheet
    
    init() {
        let PCSheetTexture = SKTexture(imageNamed: "walking_boy")
        PCSheet = SKETextureSheet(withSheet: PCSheetTexture, rows: 5, columns: 11)
        
        PCAnimation = AnimationSheet(textureSheet: PCSheet)
    }
}

class ExampleQuestScene : QuestScene, QuestSceneActors, QuestSceneEvents {
    private var _textures : ExampleTextureBatch!
    private var _PC : SKSpriteNode!
    private var _mainCamera : SKCameraNode!
    
    override func didMove(to view: SKView) {
        self.actors = self
        self.events = self
        
        _textures = ExampleTextureBatch()
        
        _PC = childNode(withName: "Sprite_PC") as? SKSpriteNode
        _PC.texture = _textures.PCSheet.texture(row: 0, column: 0)
        
        _mainCamera = childNode(withName: "mainCamera") as? SKCameraNode
        
        _PC.run(_textures.PCAnimation.animation(type: .Idle(.Top)))
    }
    
    // MARK: QuestSceneActors implementation
    var PC: SKSpriteNode {
        return _PC
    }
    
    var mainCamera: SKCameraNode {
        return _mainCamera
    }
    
    func eventHandled(_ event: QuestSceneEvent) {
        switch event {
        case .pcMoveToPoint(let point):
            pcMove(to: point)
        case .pcMoveToSprite(let sprite):
            pcMove(to: sprite.position)
        }
    }
    
    func pcMove(to point: CGPoint) {
        var animation : Animation?
        if (abs(point.x - _PC.position.x) < abs(point.y - _PC.position.y)) {
            animation = point.y > _PC.position.y ? .Walk(.Top) : .Walk(.Bottom)
        } else {
            animation = point.x > _PC.position.x ? .Walk(.Left) : .Walk(.Right)
        }
        _PC.removeAllActions()
        _PC.run(_textures.PCAnimation.animation(type: animation!))
    }
}
