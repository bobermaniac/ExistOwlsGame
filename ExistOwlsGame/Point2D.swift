//
//  Point2D.swift
//  ExistOwlsGame
//
//  Created by Victor Bryksin on 20/09/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

import SpriteKit

struct Point2D {
    public let x: Double
    public let y: Double
    
    init(_ point: CGPoint) {
        self.x = Double(point.x)
        self.y = Double(point.y)
    }
    
    init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
    
    public static func zero() -> Point2D {
        return Point2D(x: 0, y: 0)
    }
    
    func distance(to target: Point2D) -> Double {
        return sqrt(distanceSquared(to: target))
    }
    
    func distanceSquared(to target: Point2D) -> Double {
        let distanceX = self.distanceX(to: target)
        let distanceY = self.distanceY(to: target)
        return distanceX * distanceX + distanceY * distanceY
    }
    
    func distanceX(to target: Point2D) -> Double {
        return target.x - self.x
    }
    
    func distanceY(to target: Point2D) -> Double {
        return target.y - self.y
    }
    
    var cgPoint : CGPoint {
        return CGPoint(x: x, y: y)
    }
}
