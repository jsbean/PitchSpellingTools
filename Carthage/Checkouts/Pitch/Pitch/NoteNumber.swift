//
//  NoteNumber.swift
//  Pitch
//
//  Created by James Bean on 3/12/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import Foundation
import ArithmeticTools

/**
 MIDI NoteNumber.
 */
public struct NoteNumber: FloatWrapping {
    
    // MARK: - Instance Properties
    
    /// Value of this `NoteNumber`.
    public var value: Float
    
    // MARK: - Initializers
    
    /**
     Create a `NoteNumber` with `Frequency` value.
     
     **Example:**
     
     ```
     let nn = NoteNumber(440) => A below middle c
     ```
     */
    public init(_ frequency: Frequency) {
        self.value = 69.0 + (12.0 * (log(frequency.value / 440.0)/log(2.0)))
    }
 
    /**
     - `1`: quantize to a half-tone
     - `0.5`: quantize to a quarter-tone
     - `0.25`: quantize to an eighth-tone
     
     - returns: `NoteNumber` that is quantized to the desired `resolution`.
     */
    public func quantized(to resolution: Float) -> NoteNumber {
        return NoteNumber(floatLiteral: round(value / resolution) * resolution)
    }
}

extension NoteNumber: IntegerLiteralConvertible {
    
    // MARK: IntegerLiteralConvertible
    
    /**
     Create a `NoteNumber` with an `IntegerLiteralType`.
     
     **Example:**
     
     ```
     let nn: NoteNumber = 65 => F above middle C
     ```
     */
    public init(integerLiteral value: Int) {
        self.value = Float(value)
    }
}

extension NoteNumber: FloatLiteralConvertible {
    
    // MARK: FloatLiteralConvertible
    
    /**
     Create a `NoteNumber` with a `FloatLiteralType`.
     
     **Example:**
     
     ```
     let nn: NoteNumber = 65.5 // => F quarter sharp above middle C
     ```
     */
    public init(floatLiteral value: Float) {
        self.value = value
    }
}
