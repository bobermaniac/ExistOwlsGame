//
//  SKTextureFactory.swift
//  OWLAnimation4SpriteKit
//
//  Created by Victor Bryksin on 06/11/2016.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

import Foundation
import SpriteKit
import OWLAnimations

public struct SKTextureFactory: TextureFactory {
    public typealias TextureType = SKTexture
    
    public func rect(_ rect: Box2D, from texture: SKTexture) -> SKTexture {
        return SKTexture(rect: rect.cgRect, in: texture)
    }
}

public extension SKTexture {
    public var factory: SKTextureFactory { return SKTextureFactory() }
}
