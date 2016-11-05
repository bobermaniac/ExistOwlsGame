//
//  SKActionFactory.swift
//  OWLAnimation4SpriteKit
//
//  Created by Victor Bryksin on 06/11/2016.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

import Foundation
import SpriteKit
import OWLAnimations

public struct SKActionFactory : ActionFactory {
    public typealias ActionType = SKAction
    public typealias TextureType = SKTexture
    
    public func group(_ actions: [ SKAction ]) -> SKAction {
        return SKAction.group(actions)
    }
    
    public func sequence(_ actions: [ SKAction ]) -> SKAction {
        return SKAction.sequence(actions)
    }
    
    public func setTexture(_ texture: SKTexture) -> SKAction {
        return SKAction.setTexture(texture)
    }
    
    public func animate(with textures: [ SKTexture ], timePerFrame sec: TimeInterval) -> SKAction {
        return SKAction.animate(with: textures, timePerFrame: sec)
    }
    
    public func repeatForever(_ action: SKAction) -> SKAction {
        return SKAction.repeatForever(action)
    }
}

public extension SKAction {
    public var factory: SKActionFactory { return SKActionFactory() }
}
