//
//  Interval.swift
//  Pitch
//
//  Created by James Bean on 3/13/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import ArithmeticTools

/// Interval between two `Pitch` values.
public struct Interval: FloatWrapping {

    /**
     Complexity of an `Interval`.
     
     - warning: Not yet implemented.
     */
    public var complexity: Float { return 0 }
    
    public let value: Float
    
    public init(floatLiteral value: Float) {
        self.value = value
    }
    
    public init(integerLiteral value: Int) {
        self.value = Float(value)
    }
    
    /**
     Create an `Interval` with a `Dyad` of `Pitch` values.
     */
    public init(dyad: Dyad) {
        self.value = dyad.higher.noteNumber.value - dyad.lower.noteNumber.value
    }
    
    /// `IntervalClass` representation of `Interval`.
    public var intervalClass: IntervalClass { return IntervalClass(self) }
}
