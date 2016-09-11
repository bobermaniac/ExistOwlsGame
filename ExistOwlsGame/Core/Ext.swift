//
//  EnumerableExt.swift
//  ExistOwlsGame
//
//  Created by Victor Bryksin on 20/08/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

import SpriteKit

extension Sequence {
    func product<T, U>(with second: T, _ productionFunc: (_ first: Self.Iterator.Element, _ second: T.Iterator.Element) -> U) -> [ U ] where T: Sequence {
        return self.flatMap({ e1 in
            second.flatMap({ e2 in
                return productionFunc(e1, e2)
            })
        })
    }
    
    func dictionary<K, V>(literal: (Self.Iterator.Element) -> (K, V)) -> [ K : V ] {
        var dictionary: [ K : V ] = [:]
        for element in self {
            let kv = literal(element)
            dictionary[kv.0] = kv.1
        }
        return dictionary
    }
}

extension CGPoint {
    func distance(to point: CGPoint) -> CGFloat {
        return sqrt(pow(point.x - self.x, 2) + pow(point.y - self.y, 2))
    }
}

extension SKAction {
    private class SpringMove {
        private func _f(_ t: CGFloat) -> CGFloat {
            return t < 0.5 ? 4 * t * t * t : (t - 1) * (2 * t - 2) * (2 * t - 2) + 1
        }
        
        private var sourcePoint: CGPoint? = nil
        private let targetPoint: CGPoint
        private let time: CGFloat
        
        init(to point: CGPoint, in time: TimeInterval) {
            self.targetPoint = point
            self.time = CGFloat(time)
        }
        
        func impl(node: SKNode, time: CGFloat) {
            let t = time / self.time
            let k = _f(t)
            if sourcePoint == nil {
                self.sourcePoint = node.position
            }
            guard let sourcePoint = sourcePoint else {
                return
            }
            let point = CGPoint(x: sourcePoint.x + (targetPoint.x - sourcePoint.x) * k,
                                y: sourcePoint.y + (targetPoint.y - sourcePoint.y) * k)
            node.position = point
        }
    }
    
    static func springMove(to point: CGPoint, in time: TimeInterval) -> SKAction {
        return SKAction.customAction(withDuration: time,
                                      actionBlock: SpringMove(to: point, in: time).impl)
    }
}
