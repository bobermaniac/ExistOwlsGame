//
//  SKSpriteAnimatable.swift
//  ExistOwlsGame
//
//  Created by Victor Bryksin on 20/09/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

import SpriteKit

extension SKSpriteNode : Animatable {
    private static let directionKey = "direction"
    
    var position2d: Point2D {
        get {
            return Point2D(x: Double(position.x), y: Double(position.y))
        }
        set(value) {
            self.position = value.cgPoint
        }
    }
    
    var direction: Direction {
        get {
            return self.userData![SKSpriteNode.directionKey] as! Direction
        }
        set(value) {
            self.userData![SKSpriteNode.directionKey] = value
        }
    }
}
