//
//  Space2DScaleFactor.swift
//  ExistOwlsGame
//
//  Created by Victor Bryksin on 20/09/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

import Foundation


struct Space2DScaleFactor {
    let horisontalAxis: Double
    let verticalAxis: Double
    
    init() {
        horisontalAxis = 1
        verticalAxis = 1
    }
    
    init(horisontalAxisScaleFactor: Double) {
        horisontalAxis = horisontalAxisScaleFactor
        verticalAxis = 1
    }
    
    init(verticalAxisScaleFactor: Double) {
        horisontalAxis = 1
        verticalAxis = verticalAxisScaleFactor
    }
}
