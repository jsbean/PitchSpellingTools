//
//  Interval.swift
//  Pitch
//
//  Created by James Bean on 3/13/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import Foundation

/// Interval between two `Pitch` values.
public typealias Interval = Float

extension Interval {
    
    /**
     Complexity of an `Interval`.
     
     - warning: Not yet implemented.
    */
    public var complexity: Float { return 0 }
    
    /// `IntervalClass` representation of `Interval`.
    public var intervalClass: IntervalClass { return IntervalClass(self) }
    
    /**
     Create an `Interval` with a `Dyad` of `Pitch` values.
     */
    public init(_ dyad: Dyad) {
        self = dyad.higher.noteNumber - dyad.lower.noteNumber
    }
}