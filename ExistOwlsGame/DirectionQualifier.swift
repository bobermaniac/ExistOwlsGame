//
//  DirectionQualifier.swift
//  ExistOwlsGame
//
//  Created by Victor Bryksin on 20/09/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

import Foundation

protocol DirectionQualifier {
    func direction(from pt1: Point2D, to pt2: Point2D) -> Direction
}
