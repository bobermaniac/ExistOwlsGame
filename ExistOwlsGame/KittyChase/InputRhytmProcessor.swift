//
//  InputRhytmProcessor.swift
//  ExistOwlsGame
//
//  Created by Victor Bryksin on 16/08/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

import Foundation

enum PadDisposition {
    case Left
    case Right
}

enum RhytmEvent {
    case Pending(count: Int)
    case BPM(Int)
    case Broken
}

class InputRhytmProcessor {
    struct Settings  {
        var bufferLength : Int
        var maxDeviation : Double
    }
    
    struct LastEventParameters {
        let disposition: PadDisposition
        let time: TimeInterval
        
        init(_ disposition: PadDisposition, _ time: TimeInterval) {
            self.disposition = disposition
            self.time = time
        }
    }
    
    private var _events : CircularBuffer<Double>
    private var _lastEvent : LastEventParameters?
    private let _settings : Settings
    
    convenience init() {
        let settings = Settings(bufferLength: 8, maxDeviation: 0.5)
        self.init(with: settings)
    }
    
    required init(with settings: Settings) {
        _settings = settings
        _events = CircularBuffer(withCapacity: _settings.bufferLength - 1)
    }
    
    func consume(disposition: PadDisposition, inTime time: TimeInterval) -> RhytmEvent {
        defer {
            _lastEvent = LastEventParameters(disposition, time)
        }
        guard let lastEvent = _lastEvent else {
            return .Pending(count: _events.capacity)
        }
        guard lastEvent.disposition != disposition else {
            _resetEvents()
            return .Broken
        }
        return _calculateBPM(enquingDelta: time - lastEvent.time)
    }
    
    private func _calculateBPM(enquingDelta delta: TimeInterval) -> RhytmEvent {
        _events.enqueue(delta)
        if _events.count < _events.capacity {
            return .Pending(count: _events.capacity - _events.count)
        }
        let mean = _events.reduce(0.0, { $0 + $1 }) / Double(_events.count)
        let errors = _events.map({ abs(mean - $0) / mean }).filter({ $0 > _settings.maxDeviation })
        if errors.count != 0 {
            _resetEvents()
            return .Broken
        }
        return .BPM(Int(60.0 / mean))
    }
    
    private func _resetEvents() {
        _lastEvent = nil
        _events.prune()
    }
}
