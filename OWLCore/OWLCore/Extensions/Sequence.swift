//
//  Sequence.swift
//  OWLCore
//
//  Created by Victor Bryksin on 05/11/2016.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

import Foundation

public func product<T1: Sequence, T2: Sequence, U>(_ first: T1, with second: T2, _ f: (_ first: T1.Iterator.Element, _ second: T2.Iterator.Element) -> U) -> [ U ] {
    return first.product(with: second, f)
}

public extension Sequence {
    public func product<T: Sequence, U>(with second: T, _ productionFunc: (_ first: Self.Iterator.Element, _ second: T.Iterator.Element) -> U) -> [ U ] {
        return self.flatMap({ e1 in
            second.flatMap({ e2 in
                return productionFunc(e1, e2)
            })
        })
    }

    public func dictionary<K, V>(literal: (Self.Iterator.Element) -> (K, V)) -> [ K : V ] {
        var dictionary: [ K : V ] = [:]
        for element in self {
            let kv = literal(element)
            dictionary[kv.0] = kv.1
        }
        return dictionary
    }
}
