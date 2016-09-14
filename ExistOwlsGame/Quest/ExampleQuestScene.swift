//
//  ExampleQuestScene.swift
//  ExistOwlsGame
//
//  Created by Victor Bryksin on 20/08/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

import SpriteKit

class ExampleTextureBatch {
    let PCSheet : TextureSheet
    let PCAnimation : AnimationSheet
    
    init() {
        let PCSheetTexture = SKTexture(imageNamed: "walking_boy")
        PCSheet = TextureSheet(withSheet: PCSheetTexture, rows: 5, columns: 11)
        
        PCAnimation = AnimationSheet(textureSheet: PCSheet)
    }
}

class ExampleQuestScene : SKScene, SceneEventHandler {
    
    var eventRecognizer: SceneEventRecognizer = SceneEventRecognizer()
    var animationPerformer: SceneAnimationPerformer = SceneAnimationPerformer()
    // MARK: -
    
    private var _textures : ExampleTextureBatch!
    private var _PC : SKSpriteNode!
    private var _mainCamera : SKCameraNode!
    
    
    override func didMove(to view: SKView) {
        animationPerformer.delegate = eventRecognizer
        eventRecognizer.delegate = self
        
        _textures = ExampleTextureBatch()
        
        _PC = childNode(withName: "Sprite_PC") as? SKSpriteNode
        _PC.texture = _textures.PCSheet.texture(row: 0, column: 0)
        
        _mainCamera = childNode(withName: "mainCamera") as? SKCameraNode
        
        _PC.run(_textures.PCAnimation.animation(type: .Idle(.Top)))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.eventRecognizer.touchesBegan(touches, on: self)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.eventRecognizer.touchesMoved(touches, on: self)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.eventRecognizer.touchesEnded(touches, on: self)
    }
    
    func handle(sceneEvent: SceneEvent) {
        let performer = animationPerformer.initiatedBy(sceneEvent)
        switch sceneEvent {
        case .Tap(point: let point, sprite: let sprite):
            let animation = PerformingAnimation(forSprite: _PC, type: .Walk(target: sprite?.position ?? point))
            performer.perform(animation: animation, using: _textures.PCAnimation)
        case .AnimationBegins(animation: let animation):
            _handlePotentialAnimation(animation)
        case .AnimationEnded(sprite: let sprite, intent: _):
            _finishAnimation(for: sprite)
        case .Drag(delta: let delta, sprite: _):
            _mainCamera.position = CGPoint(x: _mainCamera.position.x + delta.width,
                                           y: _mainCamera.position.y + delta.height)
        default: break
        }
    }
    
    func _handlePotentialAnimation(_ animation: PotentialAnimation) {
        switch animation {
        case .Move(let info):
            if info.sprite == _PC {
                _mainCamera.run(SKAction.springMove(to: info.targetPoint, in: info.time))
            }
        }
    }
    
    func _finishAnimation(for sprite: SKSpriteNode) {
        _PC.run(_textures.PCAnimation.animation(type: .Idle(.Top)))
        _mainCamera.run(SKAction.move(to: _PC.position, duration: 1))
    }
}
