//
//  SceneAnimationPerformer.swift
//  ExistOwlsGame
//
//  Created by Victor Bryksin on 28/08/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

import SpriteKit

enum PerformingAnimation {
    case Walk(target: CGPoint)
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

class SceneAnimationPerformer {
    public var delegate: SceneEventRecognizer?
    
    func perform(animation: PerformingAnimation, on sprite: SKSpriteNode, sheet: AnimationSheet) {
        switch animation {
        case .Walk(target: let point):
            _performWalk(to: point, on: sprite, sheet: sheet)
        }
    }
    
    func _performWalk(to point: CGPoint, on sprite: SKSpriteNode, sheet: AnimationSheet) {
        let length = point.distance(to: sprite.position)
        let direction = _direction(from: sprite.position, to: point)
        let time = TimeInterval(length / 70)
        
        let infiniteLoopWalkingAnimation = sheet.animation(type: .Walk(direction))
        let transitionAnimation = SKAction.move(to: point, duration: time)
        let completionAction = SKAction.run { [unowned self] in self.delegate?.animationEnded(for: sprite, ofKind: .Walk(direction)) }
        
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
