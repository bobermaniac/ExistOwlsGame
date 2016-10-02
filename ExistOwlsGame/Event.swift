//
//  Event.swift
//  ExistOwlsGame
//
//  Created by Victor Bryksin on 02/10/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

import Foundation

enum Event {
    case nae
    case tap(point: Point2D, animatable: Animatable?)
    case grab(sprite: Animatable)
    case drag(delta: Transition2D, animatable: Animatable?)
    case drop
    case executed(command: AnimationCommand)
    case timer(name: String)
}
