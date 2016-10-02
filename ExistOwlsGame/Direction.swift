//
//  Direction.swift
//  ExistOwlsGame
//
//  Created by Victor Bryksin on 20/09/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

import Foundation

enum Direction {
    case top
    case bottom
    case left
    case right
    
    var nextCW: Direction {
        switch self {
        case .top: return .right
        case .right: return .bottom
        case .bottom: return .left
        case .left: return .top
        }
    }
}
