//
//  Size2D.swift
//  OWLAnimations
//
//  Created by Victor Bryksin on 05/11/2016.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

import Foundation
import OWLCore

public struct Size2D: Hashable, Equatable, Comparable {
    public let width: Double
    public let height: Double
    
    private var _areaSquared: Double { return width * width + height * height }
    
    public static let zero = Size2D(width: 0, height: 0)
    
    public init(width: Double, height: Double) {
        self.width = width
        self.height = height
    }
    
    public var hashValue: Int {
        return Hash.DJB2(width, height)
    }
    
    public static func == (_ lhs: Size2D, _ rhs: Size2D) -> Bool {
        return lhs.width == rhs.width && lhs.height == rhs.height
    }
    
    public static func < (_ lhs: Size2D, _ rhs: Size2D) -> Bool {
        return lhs._areaSquared < rhs._areaSquared
    }
}
