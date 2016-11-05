//
//  Box2D2CGRect.swift
//  OWLAnimation4SpriteKit
//
//  Created by Victor Bryksin on 06/11/2016.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

import Foundation
import SpriteKit
import OWLAnimations

public extension Box2D {
    public var cgRect: CGRect { return CGRect(x: origin.left, y: origin.top, width: size.width, height: size.height) }
}
