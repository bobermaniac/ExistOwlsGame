//
//  TimerPlayground.swift
//  ExistOwlsGame
//
//  Created by Victor Bryksin on 02/10/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

import Foundation

class TimerPlayground: SystemEventRecognizer {
    private struct TimerPlaygroundEventHandler: EventHandler {
        private unowned let playground: TimerPlayground
        
        init(playground: TimerPlayground) {
            self.playground = playground
        }
        
        func handle(event: Event) {
            guard case let .timer(name) = event else { return }
            playground._onTimer(name: name)
        }
    }
    
    var eventHandler: EventHandler? = nil
    
    private var timers: [ Timer ] = []
    
    func createTimer(name: String, elapsed: TimeInterval) {
        if let timer = timers.first(where: { timer in timer.name == name }) {
            timer.elapsed = elapsed
            return
        }
        let timer = Timer(withName: name, elapsed: elapsed)
        timer.handler = TimerPlaygroundEventHandler(playground: self)
        timers.append(timer)
    }
    
    func dismissTimer(name: String) {
        timers = timers.filter { timer in timer.name != name }
    }
    
    func update(_ time: TimeInterval) {
        timers.forEach { timer in timer.update(time) }
    }
    
    private func _onTimer(name: String) {
        dismissTimer(name: name)
        eventHandler?.handle(event: .timer(name: name))
    }
}
