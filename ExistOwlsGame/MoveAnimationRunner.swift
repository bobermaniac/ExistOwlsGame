//
//  MoveAnimationRunner.swift
//  ExistOwlsGame
//
//  Created by Victor Bryksin on 02/10/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

import SpriteKit

class MoveAnimationRunner : AnimationRunner {
    private let _targetPoint: Point2D
    private let _time: TimeInterval
    
    init(targetPoint: Point2D, time: TimeInterval) {
        _targetPoint = targetPoint
        _time = time
    }
    
    func run(on animatable: Animatable, sheet: AnimationSheet?, completion: @escaping AnimationPerformerCompletion) {
        let transitionAnimation = SKAction.move(to: _targetPoint.cgPoint, duration: _time)
        let completionAction = SKAction.run(completion)
        
        let animation = SKAction.sequence([ transitionAnimation, completionAction ]);
        
        animatable.removeAllActions()
        animatable.run(animation)
    }
}
