//
//  TextureFactory.swift
//  OWLAnimations
//
//  Created by Victor Bryksin on 06/11/2016.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

import Foundation

public protocol TextureFactory {
    associatedtype TextureType: Texture
    
    func rect(_ rect: Box2D, from texture: TextureType) -> TextureType
}
