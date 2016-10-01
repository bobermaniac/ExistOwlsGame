//
//  MoveAnimationRunner.swift
//  ExistOwlsGame
//
//  Created by Victor Bryksin on 20/09/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

import SpriteKit

class MoveAnimationRunner : AnimationRunner {
    private let _point: Point2D
    private let _directionQualifier : DirectionQualifier
    
    private static var directionQualifier: DirectionQualifier = DefaultDirectionQualifier()
    
    convenience init(targetPoint point: Point2D) {
        self.init(targetPoint: point, directionQualifier: MoveAnimationRunner.directionQualifier)
    }
    
    init(targetPoint point: Point2D, directionQualifier: DirectionQualifier) {
        _point = point
        _directionQualifier = directionQualifier
    }
    
    func run(on animatable: Animatable, sheet: AnimationSheet, completion: @escaping AnimationPerformerCompletion) {
        let length = _point.distance(to: animatable.position2d)
        let direction = _directionQualifier.direction(from: animatable.position2d, to: _point)
        animatable.direction = direction
        let time = TimeInterval(length / 70)
        
        let animationType = sheet.sheetAnimation(for: .buildIn(type: .walk), direction: direction)
        let infiniteLoopWalkingAnimation = sheet.animation(type: animationType!)
        let transitionAnimation = SKAction.move(to: _point.cgPoint, duration: time)
        let completionAction = SKAction.run(completion)
        
        let animation = SKAction.group([ infiniteLoopWalkingAnimation, SKAction.sequence([ transitionAnimation, completionAction ]) ]);
        
        animatable.removeAllActions()
        animatable.run(animation)
    }
}
