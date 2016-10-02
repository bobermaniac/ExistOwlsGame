//
//  IdleAnimationRunner.swift
//  ExistOwlsGame
//
//  Created by Victor Bryksin on 20/09/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

import Foundation

class IdleAnimationRunner : AnimationRunner {
    private let _direction: Direction
    
    init(direction: Direction) {
        _direction = direction
    }
    
    func run(on animatable: Animatable, sheet: AnimationSheet?, completion: @escaping () -> Void) {
        let sheet = sheet!
        
        let animationType = sheet.sheetAnimation(for: .buildIn(type: .idle), direction: _direction)
        animatable.removeAllActions()
        animatable.run(sheet.animation(type: animationType!))
    }
}
