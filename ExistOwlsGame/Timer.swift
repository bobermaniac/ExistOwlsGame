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
    
    private(set) var elapsed: TimeInterval
    
    init(withName name: String, interval: TimeInterval, repeating: Bool = false) {
        self.interval = interval
        self.elapsed = interval
        self.repeating = repeating
        self.name = name
    }
    
    func update(_ interval: TimeInterval) {
        guard self.elapsed > 0 else { return }
        
        self.elapsed -= interval
        if self.elapsed <= 0 {
            handler?.handle(event: .timer(name: name))
            if repeating {
                elapsed = self.interval - elapsed
            }
        }
    }
    
    private let repeating: Bool
    private let interval: TimeInterval
}
