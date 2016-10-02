//
//  SceneAnimationPerformer.swift
//  ExistOwlsGame
//
//  Created by Victor Bryksin on 28/08/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

import SpriteKit

class SKSceneAnimationPerformer : AnimationPerformerWithCompletion {
    var events: AnimationEventRecognizer?
    
    func perform(command: AnimationCommand, on animatable: Animatable, using sheet: AnimationSheet?, complete: @escaping AnimationPerformerCompletion) {
        var runner: AnimationRunner?
        switch command {
        case .idle:
            runner = IdleAnimationRunner(direction: animatable.direction)
        case .walk(let targetPoint):
            runner = WalkAnimationRunner(targetPoint: targetPoint)
        case .move(targetPoint: let targetPoint, time: let time):
            runner = MoveAnimationRunner(targetPoint: targetPoint, time: time)
        }
        runner?.run(on: animatable, sheet: sheet, completion: complete)
    }
}

protocol AnimationConverter {
    associatedtype AnimationType
    
    func sheetAnimation(for animation: ExistOwlsGame.Animation, direction: Direction) -> AnimationType?
}

extension AnimationSheet : AnimationConverter {
    typealias AnimationType =  AnimationSheet.Animation
    
    func sheetAnimation(for animation: ExistOwlsGame.Animation, direction: Direction) -> AnimationSheet.Animation? {
        switch animation {
        case .buildIn(type: let buildInAnimation):
            return _sheetAnimation(for: buildInAnimation, direction: direction)
        case .userDefined(name: _):
            return nil
        }
    }
    
    private func _sheetAnimation(for buildInAnimation: BuildInAnimation, direction: Direction) -> AnimationSheet.Animation? {
        switch buildInAnimation {
        case .idle:
            if direction == .bottom { return .idleBottom }
            if direction == .left { return .idleLeft }
            if direction == .right { return .idleRight }
            if direction == .top { return .idleTop }
        case .walk(point: _):
            if direction == .bottom { return .walkBottom }
            if direction == .left { return .walkLeft }
            if direction == .right { return .walkRight }
            if direction == .top { return .walkTop }
        }
        return nil
    }
}
