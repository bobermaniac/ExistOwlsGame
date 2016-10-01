//
//  SceneEventHandler.swift
//  ExistOwlsGame
//
//  Created by Victor Bryksin on 28/08/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

import SpriteKit

enum Event {
    case nae
    case tap(point: CGPoint, sprite: SKSpriteNode?)
    case grab(sprite: SKSpriteNode)
    case drag(delta: CGSize, sprite: SKSpriteNode?)
    case drop
    case executed(command: AnimationCommand)
}

protocol EventHandler {
    func handle(event: Event)
}

protocol UserInputEventRecognizer : class {
    func touchesBegan(_ touches: Set<UITouch>, on scene: SKScene)
    func touchesMoved(_ touches: Set<UITouch>, on scene: SKScene)
    func touchesEnded(_ touches: Set<UITouch>, on scene: SKScene)
}

protocol SystemEventRecognizer : class {
    func update(_ time: TimeInterval)
}

protocol AnimationEventRecognizer : class {
    func command(_ type: AnimationCommand, startedOn animatable: Animatable, causedBy event: Event)
    func command(_ type: AnimationCommand, finishedOn animatable: Animatable, causedBy event: Event)
}

class SceneEventRecognizer : UserInputEventRecognizer {
    var delegate: EventHandler? = nil
    
    private var _handlesGrab : Bool = false
    
    private func _nodes(beneath touch: UITouch, on scene: SKScene) -> [ SKNode ] {
        return scene.nodes(at: touch.location(in: scene))
    }
    
    private func _sprites(beneath touch: UITouch, on scene: SKScene) -> [ SKSpriteNode ] {
        return _nodes(beneath: touch, on: scene).flatMap { node in node as? SKSpriteNode }
    }
    
    private func _isActor(sprite: SKSpriteNode) -> Bool {
        guard let userData = sprite.userData else { return false }
        guard let value = userData["Actor"] as? Bool else { return false }
        return value
    }
    
    private func _isFirstSpriteHasGreaterZPos(_ tuple: (SKSpriteNode, SKSpriteNode)) -> Bool {
        return tuple.0.zPosition > tuple.1.zPosition
    }
    
    func touchesBegan(_ touches: Set<UITouch>, on scene: SKScene) {
        
    }
    
    func touchesMoved(_ touches: Set<UITouch>, on scene: SKScene) {
        guard let touch = touches.first else { return }
        let c = touch.location(in: scene)
        let p = touch.previousLocation(in: scene)
        let delta = CGSize(width: p.x - c.x, height: p.y - c.y)
        delegate?.handle(event: .drag(delta: delta, sprite: nil))
        _handlesGrab = true
    }
    
    func touchesEnded(_ touches: Set<UITouch>, on scene: SKScene) {
        defer { _handlesGrab = false }
        guard !_handlesGrab else { return }
        guard let touch = touches.first else { return }
        let sprite = _sprites(beneath: touch, on: scene).filter(_isActor).sorted(by: _isFirstSpriteHasGreaterZPos).first
        let location = touch.location(in: scene)
        delegate?.handle(event: .tap(point: location, sprite: sprite))
    }
}
