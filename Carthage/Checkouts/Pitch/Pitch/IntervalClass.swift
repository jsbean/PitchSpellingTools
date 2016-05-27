//
//  IntervalClass.swift
//  Pitch
//
//  Created by James Bean on 3/13/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import ArithmeticTools

/** 
 Modulo 12 representation of an `Interval` value.
 
 - TODO: Refactor to `PitchSpellingTools`.
 */
public struct IntervalClass: FloatWrapping {
    
    public typealias FloatLiteralType = Float
    
    public var value: Float
    
    public init(floatLiteral value: Float) {
        self.value = value
    }
    
    public init(integerLiteral value: Int) {
        self.value = Float(value)
    }
    
    /// Create an `IntervalClass` with an `Interval`.
    public init(_ interval: Interval) {
        self.value = interval.value % 12.0
    }
}
