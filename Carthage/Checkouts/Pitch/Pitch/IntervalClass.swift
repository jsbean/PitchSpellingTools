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
 */
public struct IntervalClass: FloatWrapping {
    
    // MARK: - Instance Properties
    
    /// Value of this `IntervalClass`.
    public var value: Float
    
    /// - warning: Not yet implemented!
    public var vector: Float { fatalError() }
    
    // MARK: - Initializers
    
    /**
     Create an `IntervalClass` with an `Interval`.
     */
    public init(_ interval: Interval) {
        self.value = interval.value % 12.0
    }
}

extension IntervalClass: IntegerLiteralConvertible {
    
    // MARK: - IntegerLiteralConvertible
    
    /**
     Create an `IntervalClass` with an `IntegerLiteral`.
     */
    public init(integerLiteral value: Int) {
        self.value = Float(value)
    }
}

extension IntervalClass: FloatLiteralConvertible {
    
    // MARK: - FloatLiteralConvertible
    
    /**
     Create an `IntervalClass` with a `FloatLiteral`.
     */
    public init(floatLiteral value: Float) {
        self.value = value
    }
}
