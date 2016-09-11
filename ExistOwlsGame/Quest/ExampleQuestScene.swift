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
        switch sceneEvent {
        case .GoToPoint(point: let point):
            animationPerformer.perform(animation: .Walk(target: point), on: _PC, sheet: _textures.PCAnimation)
        case .GoToSprite(sprite: let sprite):
            animationPerformer.perform(animation: .Walk(target: sprite.position), on: _PC, sheet: _textures.PCAnimation)
        case .AnimationBegins(animation: let animation):
            _handlePotentialAnimation(animation)
        case .AnimationEnded(sprite: let sprite, animation: let animation):
            _finishAnimation(animation, for: sprite)
        case .Grab(delta: let delta):
            _mainCamera.position = CGPoint(x: _mainCamera.position.x + delta.width,
                                           y: _mainCamera.position.y + delta.height)
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
    
    func _finishAnimation(_ animation: Animation, for sprite: SKSpriteNode) {
        _PC.removeAllActions()
        switch animation {
        case .Walk(let direction):
            _PC.run(_textures.PCAnimation.animation(type: .Idle(direction)))
            _mainCamera.run(SKAction.move(to: _PC.position, duration: 1))
        default: break
        }
    }
}
