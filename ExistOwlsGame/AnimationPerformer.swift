//
//  AnimationPerformer.swift
//  ExistOwlsGame
//
//  Created by Victor Bryksin on 20/09/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

import SpriteKit

typealias AnimationPerformerCompletion = () -> Void

protocol AnimationPerformer {
    var events: AnimationEventRecognizer? { get set }
    
    func perform(command: AnimationCommand, on animatable: Animatable, using sheet: AnimationSheet?)
}

protocol InitiatedAnimationPerformer {
    func by(_ event: Event, to target: SceneEventRecognizer) -> AnimationPerformer
}

protocol AnimationPerformerWithCompletion : AnimationPerformer {
    func perform(command: AnimationCommand, on animatable: Animatable, using sheet: AnimationSheet?, complete: @escaping AnimationPerformerCompletion)
}
