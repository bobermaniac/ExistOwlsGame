//
//  Animation.swift
//  ExistOwlsGame
//
//  Created by Victor Bryksin on 20/09/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

import Foundation

enum Animation {
    case buildIn(type: BuildInAnimation)
    case userDefined(name: String)
}

enum BuildInAnimation {
    case idle
    case walk
}

enum AnimationCommand {
    case idle
    case move(targetPoint: Point2D, time: TimeInterval)
    case walk(targetPoint: Point2D)
}
