//
//  RingBuffer.swift
//  ExistOwlsGame
//
//  Created by Victor Bryksin on 16/08/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

import Foundation

struct CircularBufferIterator<T> : IteratorProtocol {
    typealias Element = T
    
    private let _buffer: [ T? ]
    private var _index : Int
    private let _endIndex : Int
    private var _finished : Bool
    
    init() {
        _buffer = []
        _index = 0
        _endIndex = 0
        _finished = true
    }
    
    init(withInternalBuffer buffer: [ T? ], start startIndex: Int, end endIndex: Int) {
        _buffer = buffer
        _index = startIndex
        _endIndex = endIndex
        _finished = false
    }
    
    mutating func next() -> T? {
        guard !_finished else {
            return nil
        }
        let result = _buffer[_index];
        _index = (_index + 1) % _buffer.capacity
        if (_index == _endIndex) {
            _finished = true
        }
        return result
    }
}

struct CircularBuffer<T> : Sequence {
    private var _items : [ T? ]
    private var _head : Int
    private var _tail : Int
    private var _empty : Bool
    
    init(withCapacity capacity: Int) {
        self.capacity = capacity
        
        _items = Array(repeating: nil, count: capacity)
        _head = 0
        _tail = 0
        _empty = true
    }
    
    mutating func enqueue(_ item : T) {
        if _head == _tail && !_empty {
            _head = _curcularShift(_head)
        }
        _items[_tail] = item
        _tail = _curcularShift(_tail)
        _empty = false
    }
    
    var count: Int {
        return (_tail > _head ? _tail  : _tail + _items.capacity) - _head
    }
    
    private(set) var capacity: Int
    
    func pick() -> T? {
        guard _head != _tail else {
            return nil
        }
        return _items[_head]
    }
    
    mutating func dequeue() -> T? {
        guard _head != _tail else {
            return nil
        }
        let result = _items[_head]
        _items[_head] = nil
        _head = _curcularShift(_head)
        
        return result
    }
    
    mutating func prune() {
        if _empty {
            return
        }
        while _head != _tail {
            _items[_head] = nil
            _head = _curcularShift(_head)
        }
        _head = 0
        _tail = 0
        _empty = true
    }
    
    private func _curcularShift(_ i : Int) -> Int {
        return (i + 1) % capacity
    }
    
    typealias Iterator = CircularBufferIterator<T>
    
    func makeIterator() -> CircularBufferIterator<T> {
        if _empty {
            return CircularBufferIterator()
        }
        return CircularBufferIterator(withInternalBuffer: _items, start: _head, end: _tail)
    }
}
