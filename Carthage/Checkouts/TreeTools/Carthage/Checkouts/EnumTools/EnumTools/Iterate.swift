//
//  Iterate.swift
//  EnumTools
//
//  Created by James Bean on 2/24/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import Foundation

/**
 Iterate over an Enum type.
 
 ```
 for instrumentKind in iterateEnum(InstrumentKind) { ... }
 ```
 
 - TODO: Embed in a `SequenceType` conforming structure:
 
 **Example:**
 
 ```
 let allCases: [InstrumentKind] = iterateEnum(InstrumentKind).map { $0 }
 ```
 
 - authors: [rintaro](http://stackoverflow.com/users/3804019/rintaro) / 
    [kemetrixom](http://stackoverflow.com/users/3443689/kametrixom) @ 
    [Stackoverflow](http://stackoverflow.com/a/28341290).
 
 - parameter _: Enum type.
 
 - returns: Next case of given Enum type. `nil` once last case has been reached.
 */
public func iterateEnum<T: Hashable>(_: T.Type) -> AnyIterator<T> {
    var i = 0
    return AnyIterator {
        let next = withUnsafePointer(to: &i) {
            $0.withMemoryRebound(to: T.self, capacity: 1) { $0.pointee }
        }
        if next.hashValue != i { return nil }
        i += 1
        return next
    }
}

public extension RawRepresentable where Self: Hashable {
    
    /**
     All cases of a given `enum`.
     
     - TODO: Implement `EnumSequence` to enable `.map { $0 }` to avoid `for-loop`.
     */
    static var allCases: [Self] {
        var allCases: [Self] = []
        for c in iterateEnum(Self.self) { allCases.append(c) }
        return allCases
    }
}

