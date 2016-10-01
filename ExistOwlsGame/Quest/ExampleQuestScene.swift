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

class ExampleQuestScene : SKScene, EventHandler, AnimationEventRecognizer {
    var eventRecognizer: SceneEventRecognizer = SceneEventRecognizer()
    var animationPerformer: AnimationPerformerWithCompletion = SKSceneAnimationPerformer()
    // MARK: -
    
    private var _textures : ExampleTextureBatch!
    private var _PC : SKSpriteNode!
    private var _mainCamera : SKCameraNode!
    
    
    override func didMove(to view: SKView) {
        eventRecognizer.delegate = self
        animationPerformer.events = self
        
        _textures = ExampleTextureBatch()
        
        _PC = childNode(withName: "Sprite_PC") as? SKSpriteNode
        _PC.texture = _textures.PCSheet.texture(row: 0, column: 0)
        
        _mainCamera = childNode(withName: "mainCamera") as? SKCameraNode
        
        _PC.run(_textures.PCAnimation.animation(type: .idleTop))
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
    
    // MARK: - AnimationEventRecognizer implementation
    
    func command(_ type: AnimationCommand, startedOn animatable: Animatable, causedBy event: Event) {
        
    }
    
    func command(_ type: AnimationCommand, finishedOn animatable: Animatable, causedBy event: Event) {
        let performer = animationPerformer.by(.executed(command: type))
        switch type {
        case .walk(targetPoint: _):
            performer.perform(command: .idle, on: animatable, using: _textures.PCAnimation)
        default:
            break
        }

    }
    
    // MARK: - EventHandler implementation
    
    func handle(event: Event) {
        let performer = animationPerformer.by(event)
        switch event {
        case .tap(point: let point, sprite: let optionalSprite):
            if let sprite = optionalSprite {
                _doPC(goto: sprite, with: performer)
            } else {
                _doPC(goto: Point2D(point), with: performer)
            }
        case .drag(delta: let delta, sprite: _):
            _doCamera(drag: delta)
        default:
            break
        }
    }
    
    // MARK: - Animations
    
    private func _doPC(goto point: Point2D, with performer: AnimationPerformer) {
        performer.perform(command: .walk(targetPoint: point), on: _PC, using: _textures.PCAnimation)
    }
    
    private func _doPC(goto sprite: SKSpriteNode, with performer: AnimationPerformer) {
        
    }
    
    private func _doCamera(drag offset: CGSize) {
        _mainCamera.position = _mainCamera.position.applying(CGAffineTransform.init(translationX: offset.width, y: offset.height))
    }
}
