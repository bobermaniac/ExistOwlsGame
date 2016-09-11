//
//  SceneEventHandler.swift
//  ExistOwlsGame
//
//  Created by Victor Bryksin on 28/08/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

import SpriteKit

enum SceneEvent {
    case GoToPoint(point: CGPoint)
    case GoToSprite(sprite: SKSpriteNode)
    case Grab(delta: CGSize)
    case AnimationBegins(animation: PotentialAnimation)
    case AnimationEnded(sprite: SKSpriteNode, animation: Animation)
}

protocol SceneEventHandler {
    func handle(sceneEvent: SceneEvent)
}

class SceneEventRecognizer {
    var delegate: SceneEventHandler? = nil
    
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
        delegate?.handle(sceneEvent: .Grab(delta: delta))
        _handlesGrab = true
    }
    
    func touchesEnded(_ touches: Set<UITouch>, on scene: SKScene) {
        defer { _handlesGrab = false }
        guard !_handlesGrab else { return }
        guard let touch = touches.first else { return }
        let sprite = _sprites(beneath: touch, on: scene).filter(_isActor).sorted(by: _isFirstSpriteHasGreaterZPos).first
        if let sprite = sprite {
            delegate?.handle(sceneEvent: .GoToSprite(sprite: sprite))
        } else {
            delegate?.handle(sceneEvent: .GoToPoint(point: touch.location(in: scene)))
        }
    }
    
    func animationWillBegin(_ animation: PotentialAnimation) {
        delegate?.handle(sceneEvent: .AnimationBegins(animation: animation))
    }
    
    func animationEnded(for sprite: SKSpriteNode, ofKind kind: Animation) {
        delegate?.handle(sceneEvent: .AnimationEnded(sprite: sprite, animation: kind))
    }
}
