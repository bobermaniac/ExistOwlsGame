//
//  Hash.swift
//  OWLCore
//
//  Created by Victor Bryksin on 05/11/2016.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

import Foundation

public final class Hash {
    public static func DJB2(_ first: AnyHashable, _ second: AnyHashable) -> Int {
        var hash = 5381
        hash = ((hash << 5) + hash) + first.hashValue
        hash = ((hash << 5) + hash) + second.hashValue
        return hash
    }
}
