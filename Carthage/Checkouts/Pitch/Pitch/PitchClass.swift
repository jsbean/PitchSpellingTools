//
//  Class.swift
//  Pitch
//
//  Created by James Bean on 3/13/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import ArithmeticTools

/**
 Modulo 12 representation of `noteNumber` of `Pitch`.
 */
public struct PitchClass: FloatWrapping {
    
    // MARK: - Instance Properties
    
    /// Value of `PitchClass`.
    public var value: Float
    
    /// Inversion of `PitchClass`.
    public var inversion: PitchClass { return PitchClass(12 - self.value) }
}

extension PitchClass: ExpressibleByIntegerLiteral {
    
    // MARK: - IntegerLiteralConvertible
    
    /**
     Create a `PitchClass` with an `IntegerLiteralType`.
     
     **Example:**
     
     ```
     let pitchClass = 49 // => 1.0
     ```
     */
    public init(integerLiteral value: Int) {
        self.value = Float(value).truncatingRemainder(dividingBy: 12.0)
    }
}

extension PitchClass: ExpressibleByFloatLiteral {
    
    // MARK: - IntegerLiterlConvertible
    
    /**
     Create a `PitchClass` with a `FloatLiteralType`.
     
     **Example:**
     
     ```
     let pitchClass = 49.5 // => 1.5
     ```
     */
    public init(floatLiteral: Float) {
        self.value = floatLiteral.truncatingRemainder(dividingBy: 12.0)
    }
}

extension PitchClass: PitchConvertible {
    
    // MARK: - PitchConvertible
    
    /**
     Create a `PitchClass` with a `Pitch` object.
     
     **Example:**
     
     ```
     let pitch = Pitch(noteNumber: 65.5)
     PitchClass(pitch) // => 5.5
     ```
     */
    public init(_ pitch: Pitch) {
        self.value = pitch.noteNumber.value.truncatingRemainder(dividingBy: 12.0)
    }
}
