//
//  AnimationRunner.swift
//  ExistOwlsGame
//
//  Created by Victor Bryksin on 20/09/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

import Foundation

protocol AnimationRunner {
    func run(on animatable: Animatable, sheet: AnimationSheet?, completion: @escaping AnimationPerformerCompletion)
}
