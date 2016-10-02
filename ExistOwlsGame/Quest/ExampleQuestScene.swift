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
    var timerPlayground: TimerPlayground = TimerPlayground()
    // MARK: -
    
    private var _textures : ExampleTextureBatch!
    private var _PC : SKSpriteNode!
    private var _mainCamera : SKCameraNode!
    
    
    override func didMove(to view: SKView) {
        eventRecognizer.delegate = self
        animationPerformer.events = self
        timerPlayground.eventHandler = self
        
        _textures = ExampleTextureBatch()
        
        _PC = childNode(withName: "Sprite_PC") as? SKSpriteNode
        _PC.direction = .bottom
        _doPC(idleWith: animationPerformer.by(.nae))
        
        _mainCamera = childNode(withName: "mainCamera") as? SKCameraNode
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
    
    private var lastTime: TimeInterval? = nil
    
    override func update(_ currentTime: TimeInterval) {
        defer {
            self.lastTime = currentTime
        }
        guard let lastTime = self.lastTime else {
            return
        }
        timerPlayground.update(currentTime - lastTime)
    }
    
    // MARK: - AnimationEventRecognizer implementation
    
    func command(_ type: AnimationCommand, startedOn animatable: Animatable, causedBy event: Event) {
        guard _PC === animatable else { return }
        
        switch type {
        case .idle:
            timerPlayground.createTimer(name: "idle", elapsed: 1)
            break
        default:
            break
        }
    }
    
    func command(_ type: AnimationCommand, finishedOn animatable: Animatable, causedBy event: Event) {
        guard _PC === animatable else { return }
        let performer = animationPerformer.by(.executed(command: type))
        
        switch type {
        case .walk(targetPoint: _):
            _doPC(command: .idle, with: performer)
            if case let .tap(point: _, animatable: target) = event {
                if let target = target {
                    target.position2d = target.position2d + Transition2D(dx: 0, dy: -10)
                }
            }
        default:
            break
        }
    }
    
    // MARK: - EventHandler implementation
    
    func handle(event: Event) {
        let performer = animationPerformer.by(event)
        switch event {
        case .tap(point: let point, animatable: let optAnimatable):
            if let animatable = optAnimatable {
                _doPC(goto: animatable, with: performer)
            } else {
                _doPC(goto: point, with: performer)
            }
        case .drag(delta: let delta, animatable: _):
            _doCamera(drag: delta)
        case .timer(name: let name):
            if name == "idle" {
                _PC.direction = _PC.direction.nextCW
                _doPC(idleWith: performer)
            }
        default:
            break
        }
    }
    
    // MARK: - Animations
    
    private func _doPC(goto point: Point2D, with performer: AnimationPerformer) {
        _doPC(command: .walk(targetPoint: point), with: performer)
    }
    
    private func _doPC(goto sprite: Animatable, with performer: AnimationPerformer) {
        _doPC(goto: sprite.position2d, with: performer)
    }
    
    private func _doPC(idleWith performer: AnimationPerformer) {
        _doPC(command: .idle, with: performer)
    }
    
    private func _doPC(command: AnimationCommand, with performer: AnimationPerformer) {
        timerPlayground.dismissTimer(name: "idle")
        performer.perform(command: command, on: _PC, using: _textures.PCAnimation)
    }

    private func _doCamera(drag offset: Transition2D) {
        let transition = offset.cgSize
        _mainCamera.position = _mainCamera.position.applying(CGAffineTransform.init(translationX: transition.width, y: transition.height))
    }
}
