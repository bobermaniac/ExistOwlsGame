//
//  LoopIndex.swift
//  ExistOwlsGame
//
//  Created by Victor Bryksin on 20/08/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

import Foundation

struct LoopIndex {
    private(set) var value : Int
    
    private let max : Int
    
    init(startingWith value: Int, maximum: Int) {
        self.value = value
        self.max = maximum
    }
    
    func successor() -> LoopIndex {
        return LoopIndex(startingWith: next(valueFor: value, maxedBy: max), maximum: max)
    }
    
    mutating func increment() {
        value = next(valueFor: value, maxedBy: max)
    }
    
    private func next(valueFor value: Int, maxedBy max: Int) -> Int {
        return (value + 1) % (max + 1)
    }
}
