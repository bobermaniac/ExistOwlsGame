//
//  IntegralIndex2.swift
//  OWLAnimations
//
//  Created by Victor Bryksin on 05/11/2016.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

import Foundation

internal class IntegralIndex2: Hashable {
    public let row: UInt
    public let column: UInt
    
    init(row: UInt, column: UInt) {
        self.row = row
        self.column = column
    }
    
    public var hashValue: Int {
        return self.row.hashValue * 17 ^ self.column.hashValue
    }
    
    public static func ==(lhs: IntegralIndex2, rhs: IntegralIndex2) -> Bool {
        return lhs.column == rhs.column && lhs.row == rhs.row
    }
}
