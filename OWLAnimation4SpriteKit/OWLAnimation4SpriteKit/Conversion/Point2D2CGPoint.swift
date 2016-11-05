//
//  Point2D2CGPoint.swift
//  OWLAnimation4SpriteKit
//
//  Created by Victor Bryksin on 06/11/2016.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

import Foundation
import SpriteKit
import OWLAnimations

public extension Point2D {
    public var cgPoint: CGPoint { return CGPoint(x: left, y: top) }
}
