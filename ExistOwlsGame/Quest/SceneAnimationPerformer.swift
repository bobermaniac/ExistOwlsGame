//
//  SceneAnimationPerformer.swift
//  ExistOwlsGame
//
//  Created by Victor Bryksin on 28/08/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

import SpriteKit

struct Intent {
    let event: SceneEvent
    let action: SceneAction
    
    init(withEvent event: SceneEvent, action: SceneAction) {
        self.event = event
        self.action = action
    }
}

enum SceneAction {
    case Walk(target: CGPoint)
}

struct PerformingAnimation {
    let sprite: SKSpriteNode
    let type: SceneAction
    
    init(forSprite sprite: SKSpriteNode, type: SceneAction) {
        self.sprite = sprite
        self.type = type
    }
}

struct MoveAnimationInfo {
    let sprite: SKSpriteNode
    let targetPoint: CGPoint
    let time: TimeInterval
    
    init(for sprite: SKSpriteNode, moving targetPoint: CGPoint, in time: TimeInterval) {
        self.sprite = sprite
        self.targetPoint = targetPoint
        self.time = time
    }
}

enum PotentialAnimation {
    case Move(MoveAnimationInfo)
}

protocol InitiatedAnimationPerformer {
    func perform(animation: PerformingAnimation, using sheet: AnimationSheet)
}

protocol AnimationPerformer : InitiatedAnimationPerformer {
    func initiatedBy(_ event: SceneEvent) -> InitiatedAnimationPerformer
}

class SceneAnimationPerformer : AnimationPerformer {
    
    // MARK: Intented implementation
    
    private class _InitiatedWrapper : InitiatedAnimationPerformer {
        private let parent: SceneAnimationPerformer
        private let event: SceneEvent
        
        init(withParent parent: SceneAnimationPerformer, event: SceneEvent) {
            self.parent = parent
            self.event = event
        }
        
        func perform(animation: PerformingAnimation, using sheet: AnimationSheet) {
            guard let delegate = parent.delegate else {
                parent.perform(animation: animation, using: sheet)
            }
            let intent = Intent(withEvent: event, action: animation.type)
            parent._perform(animation: animation, using: sheet) {
                delegate.animationEnded(for: animation.sprite, intented: intent)
            }
        }
    }
    
    func initiatedBy(_ event: SceneEvent) -> InitiatedAnimationPerformer {
        return _InitiatedWrapper(withParent: self, event: event)
    }
    
    // MARK: Animation performer
    
    public var delegate: SceneEventRecognizer?
    
    func perform(animation: PerformingAnimation, using sheet: AnimationSheet) {
        _perform(animation: animation, using: sheet, completion: { })
    }
    
    private func _perform(animation: PerformingAnimation, using sheet: AnimationSheet, completion: @escaping () -> Void) {
        switch animation.type {
        case .Walk(target: let point):
            _performWalk(to: point, on: animation.sprite, sheet: sheet, completion: completion)
        }
    }
    
    private func _performWalk(to point: CGPoint, on sprite: SKSpriteNode, sheet: AnimationSheet, completion: @escaping () -> Void) {
        let length = point.distance(to: sprite.position)
        let direction = _direction(from: sprite.position, to: point)
        let time = TimeInterval(length / 70)
        
        let infiniteLoopWalkingAnimation = sheet.animation(type: .Walk(direction))
        let transitionAnimation = SKAction.move(to: point, duration: time)
        let completionAction = SKAction.run(completion)
        
        let animation = SKAction.group([ infiniteLoopWalkingAnimation, SKAction.sequence([ transitionAnimation, completionAction ]) ]);
        
        delegate?.animationWillBegin(.Move(MoveAnimationInfo(for: sprite, moving: point, in: time)))
        sprite.removeAllActions()
        sprite.run(animation)
    }
    
    func _direction(from source: CGPoint, to destination: CGPoint) -> Direction {
        var direction = Direction.Top
        if (abs(destination.x - source.x) < abs(destination.y - source.y)) {
            direction = destination.y > source.y ? .Top : .Bottom
        } else {
            direction = destination.x > source.x ? .Left : .Right
        }
        return direction
    }
}
