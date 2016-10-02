//
//  Transition2D.swift
//  ExistOwlsGame
//
//  Created by Victor Bryksin on 02/10/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

import CoreGraphics

struct Transition2D {
    let dx: Double
    let dy: Double
    
    init() {
        self.dx = 0
        self.dy = 0
    }
    
    init(dx: Double, dy: Double) {
        self.dx = dx
        self.dy = dy
    }
    
    init(_ size: CGSize) {
        self.dx = Double(size.width)
        self.dy = Double(size.height)
    }
    
    var cgSize: CGSize {
        return CGSize(width: dx, height: dy)
    }
}
