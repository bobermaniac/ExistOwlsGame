//
//  SingleFrameAnimationFactory.swift
//  OWLAnimations
//
//  Created by Victor Bryksin on 06/11/2016.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

import Foundation

public final class SingleFrameAnimationFactory {
    private let _row: UInt
    private let _column: UInt
    
    public init(withRow row: UInt, column: UInt) {
        _row = row
        _column = column
    }
    
    func makeAnimation<F: ActionFactory, S: TextureSheet>(from sheet: S, using factory: F) -> F.ActionType where F.TextureType == S.TextureType {
        return factory.setTexture(sheet.texture(row: _row, column: _column))
    }
}
