//
//  DefaultDirectionQualifier.swift
//  ExistOwlsGame
//
//  Created by Victor Bryksin on 20/09/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

import Foundation

class DefaultDirectionQualifier : DirectionQualifier {
    private let _ssf: Space2DScaleFactor
    
    convenience init() {
        self.init(withSpaceScaleFactor: Space2DScaleFactor())
    }
    
    init(withSpaceScaleFactor factor: Space2DScaleFactor) {
        _ssf = factor
    }
    
    func direction(from source: Point2D, to destination: Point2D) -> Direction {
        let horisontalDistance = source.distanceX(to: destination) * _ssf.horisontalAxis
        let verticalDistance = source.distanceY(to: destination) * _ssf.verticalAxis
        if (fabs(horisontalDistance) < fabs(verticalDistance)) {
            return verticalDistance > 0 ? .top : .bottom
        } else {
            return horisontalDistance > 0 ? .left : .right
        }
    }
}
