//
//  Box2D.swift
//  OWLAnimations
//
//  Created by Victor Bryksin on 05/11/2016.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

import Foundation
import OWLCore

public struct Box2D: Hashable, Equatable {
    public let origin: Point2D
    public let size: Size2D
    
    public init(origin: Point2D, size: Size2D) {
        self.origin = origin
        self.size = size
    }
    
    public init(left: Double, top: Double, width: Double, height: Double) {
        let origin = Point2D(left: left, top: top)
        let size = Size2D(width: width, height: height)
        self.init(origin: origin, size: size)
    }
    
    public init?(left: Double, top: Double, right: Double, bottom: Double) {
        guard right >= left else { return nil }
        guard bottom >= top else { return nil }
        
        self.init(left: left, top: top, width: right - left, height: bottom - top)
    }
    
    public var hashValue: Int {
        return Hash.DJB2(origin, size)
    }
    
    public static func == (_ lhs: Box2D, _ rhs: Box2D) -> Bool {
        return lhs.origin == rhs.origin && lhs.size == rhs.size
    }
}
