//
//  Timer.swift
//  ExistOwlsGame
//
//  Created by Victor Bryksin on 02/10/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

import Foundation

class Timer {
    var handler: EventHandler? = nil
    let name: String
    
    private var elapsed: TimeInterval
    
    init(withName name: String, elapsed: TimeInterval) {
        self.elapsed = elapsed
        self.name = name
    }
    
    func update(_ interval: TimeInterval) {
        self.elapsed -= interval
        if self.elapsed < 0 {
            handler?.handle(event: .timer(name: name))
        }
    }
}
