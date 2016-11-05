//
//  AnimationSheetItemExtractor.swift
//  OWLAnimations
//
//  Created by Victor Bryksin on 05/11/2016.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

import Foundation

public protocol TextureAnimationFactory {
    func makeAnimation<F: ActionFactory, S: TextureSheet>(from sheet: S, using factory: F) -> F.ActionType where F.TextureType == S.TextureType
}
