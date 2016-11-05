//
//  SingleRowAnimationFactory.swift
//  OWLAnimations
//
//  Created by Victor Bryksin on 06/11/2016.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

import Foundation

public final class SingleRowAnimationFactory {
    private let _row: UInt
    private let _frameInterval: TimeInterval
    
    public init(withRow row: UInt, frameInterval: TimeInterval) {
        _row = row
        _frameInterval = frameInterval
    }
    
    func makeAnimation<F: ActionFactory, S: TextureSheet>(from sheet: S, using factory: F) -> F.ActionType where F.TextureType == S.TextureType {
        return factory.repeatForever(factory.animate(with: sheet.textures(inRow: _row), timePerFrame: _frameInterval))
    }
}
