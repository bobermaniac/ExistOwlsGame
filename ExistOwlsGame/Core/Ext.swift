//
//  EnumerableExt.swift
//  ExistOwlsGame
//
//  Created by Victor Bryksin on 20/08/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

import UIKit

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
