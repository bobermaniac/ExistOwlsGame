//
//  ActionFactory.swift
//  OWLAnimations
//
//  Created by Victor Bryksin on 05/11/2016.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

import Foundation

public protocol ActionFactory {
    associatedtype ActionType /* : Action */
    associatedtype TextureType /* : Texture */
    
    func group(_ actions: [ ActionType ]) -> ActionType
    func sequence(_ actions: [ ActionType ]) -> ActionType
    
    func setTexture(_ texture: TextureType) -> ActionType
    func animate(with textures: [ TextureType ], timePerFrame sec: TimeInterval) -> ActionType
    
    func repeatForever(_ action: ActionType) -> ActionType
}
