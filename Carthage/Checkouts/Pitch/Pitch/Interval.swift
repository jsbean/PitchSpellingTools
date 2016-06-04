
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
    
    // MARK: - Instance Properties
    
    /// Value of this `Interval`.
    public var value: Float
    
    /**
     Create an `Interval` with a `Dyad` of `Pitch` values.
     */
    public init(dyad: Dyad) {
        self.value = dyad.higher.noteNumber.value - dyad.lower.noteNumber.value
    }
}

extension Interval: IntegerLiteralConvertible {
    
    // MARK: - IntegeralLiteralConvertible
    
    /**
     Create an `Interval` with an `IntegerLiteral`
     */
    public init(integerLiteral value: Int) {
        self.value = Float(value)
    }
}

extension Interval: FloatLiteralConvertible {
    
    // MARK: - FloatLiteralConvertible
    
    /**
     Create an `Interval` with a `FloatLiteral`.
     */
    public init(floatLiteral value: Float) {
        self.value = value
    }
}