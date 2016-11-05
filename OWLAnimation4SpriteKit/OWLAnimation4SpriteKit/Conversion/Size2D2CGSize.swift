//
//  Size2D2CGSize.swift
//  OWLAnimation4SpriteKit
//
//  Created by Victor Bryksin on 06/11/2016.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

import Foundation
import SpriteKit
import OWLAnimations

public extension Size2D {
    public var cgSize: CGSize { return CGSize(width: width, height: height) }
}
