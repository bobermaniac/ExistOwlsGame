//
//  TimerPlayground.swift
//  ExistOwlsGame
//
//  Created by Victor Bryksin on 02/10/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

import Foundation

class Timers: SystemEventRecognizer {
    private struct TimerPlaygroundEventHandler: TimerEventHandler {
        private unowned let playground: Timers
        
        init(playground: Timers) {
            self.playground = playground
        }
        
        func onTimerExausted(_ timer: TimerWatchdog) {
            playground._onTimer(name: timer.name)
        }
    }
    
    var eventHandler: EventHandler? = nil
    
    private var timers: [ TimerWatchdog ] = []
    
    func createTimer(name: String, interval: TimeInterval) {
        dismissTimer(name: name)
        
        let timer = TimerWatchdog(withName: name, interval: interval)
        timer.handler = TimerPlaygroundEventHandler(playground: self)
        timers.append(timer)
    }
    
    func dismissTimer(name: String) {
        if let index = timers.index(where: { timer in timer.name == name }) {
            timers.remove(at: index)
        }
    }
    
    func update(_ time: TimeInterval) {
        timers.forEach { timer in timer.update(time) }
    }
    
    private func _onTimer(name: String) {
        dismissTimer(name: name)
        eventHandler?.handle(event: .timer(name: name))
    }
}
