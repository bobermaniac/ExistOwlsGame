//
//  Point2D.swift
//  OWLAnimations
//
//  Created by Victor Bryksin on 05/11/2016.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

import Foundation
import OWLCore

public struct Point2D: Hashable, Equatable {
    public let left: Double
    public let top: Double
    
    public init(left: Double, top: Double) {
        self.left = left
        self.top = top
    }
    
    public var hashValue: Int {
        return Hash.DJB2(left, top)
    }
    
    public static func == (_ lhs: Point2D, _ rhs: Point2D) -> Bool {
        return lhs.left == rhs.left && lhs.top == rhs.top
    }
}
