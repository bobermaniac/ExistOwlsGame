//
//  Animatable.swift
//  ExistOwlsGame
//
//  Created by Victor Bryksin on 20/09/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

import SpriteKit

protocol Animatable: class {
    var position2d: Point2D { get }
    var direction: Direction { get set }
    
    func run(_ action: SKAction)
    func removeAllActions()
}
