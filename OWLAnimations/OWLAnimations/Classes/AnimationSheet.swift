//
//  AnimationSheet.swift
//  OWLAnimations
//
//  Created by Victor Bryksin on 05/11/2016.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

import Foundation

public protocol AnimationSheet {
    associatedtype RawAnimationType: RawRepresentable
    associatedtype TextureType : Texture
    
    func animation<F: ActionFactory>(_ type: RawAnimationType, using factory: F) -> F.ActionType? where F.TextureType == TextureType
}

public final class AnimationSheetImpl<T: TextureSheet, E: RawRepresentable & Hashable> : AnimationSheet {
    public typealias RawAnimationType = E
    public typealias TextureType = T.TextureType
    
    private let _factories: [ E : TextureAnimationFactory ]
    private let _sheet: T
    
    public init(withTextureSheet sheet: T, factories: [ E : TextureAnimationFactory ]) {
        _sheet = sheet
        _factories = factories
    }
    
    public func animation<F: ActionFactory>(_ type: E, using factory: F) -> F.ActionType? where F.TextureType == T.TextureType {
        let f = _factories[type]
        return f?.makeAnimation(from: _sheet, using: factory)
    }
}

public enum AnimationSheetImplBuilderError: Error {
    case noSheet
    case noAnimations
}

public final class AnimationSheetImplBuilder<T: TextureSheet, E: RawRepresentable & Hashable> {
    public var factories: [ E : TextureAnimationFactory ] = [:]
    public var sheet: T? = nil
    
    public init() { }
    
    public func build() throws -> AnimationSheetImpl<T, E> {
        typealias Err = AnimationSheetImplBuilderError
        
        guard factories.count > 0 else { throw Err.noAnimations }
        guard let sheet = sheet else { throw Err.noSheet }
        
        return AnimationSheetImpl(withTextureSheet: sheet, factories: factories)
    }
}
