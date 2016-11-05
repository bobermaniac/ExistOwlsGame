//
//  Texture4SKTexture.swift
//  OWLAnimation4SpriteKit
//
//  Created by Victor Bryksin on 06/11/2016.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

import Foundation
import SpriteKit
import OWLAnimations

extension SKTexture : Texture {
    public var size: Size2D {
        return Size2D(width: 1, height: 1)
    }
}
