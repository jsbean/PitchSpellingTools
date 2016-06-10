//
//  Pitch.swift
//  Pitch
//
//  Created by James Bean on 3/12/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import ArithmeticTools

/**
 The quality of a sound governed by the rate of vibrations producing it.
 */
public struct Pitch {
    
    // MARK: - Type Properties
    
    /// Middle C.
    public static let middleC = Pitch(noteNumber: 60.0)
    
    // MARK: - Type Methods
    
    /**
     - returns: NoteNumber with a random `NoteNumber` value between 60 and 72, with the given
     `resolution`.
     */
    public static func random(resolution resolution: Float = 1) -> Pitch {
        return Pitch(noteNumber: NoteNumber.random(resolution: resolution))
    }
    
    // MARK: - Instance Properties
    
    /// `NoteNumber` representation of `Pitch`.
    public let noteNumber: NoteNumber
    
    /// `Frequency` representation of `Pitch`.
    public let frequency: Frequency
    
    /// Modulo 12 representation of `NoteNumber` representation of `Pitch`.
    public var pitchClass: PitchClass { return PitchClass(self) }
    
    // MARK: - Initializers
    
    /**
     Create a `Pitch` with a `NoteNumber` value.
     
     **Example:**
     ```
     let p = Pitch(noteNumber: 60) // => middle C
     ```
     */
    public init(noteNumber: NoteNumber) {
        self.noteNumber = noteNumber
        self.frequency = Frequency(noteNumber)
    }
    
    /**
     Create a `Pitch` with a `Frequency` value.
     
     **Example:**
     ```
     let p = Pitch(frequency: 440) // => A below middle C
     ```
     */
    public init(frequency: Frequency) {
        self.frequency = frequency
        self.noteNumber = NoteNumber(frequency)
    }
}

extension Pitch: PitchConvertible {
    
    // MARK: - PitchConvertible
    
    /**
     Create a `Pitch` with another `Pitch`.
     */
    public init(_ pitch: Pitch) {
        self.frequency = pitch.frequency
        self.noteNumber = NoteNumber(pitch.frequency)
    }
}

extension Pitch: FloatLiteralConvertible {
    
    // MARK: - FloatLiteralConvertible
    
    /**
     Create a `Pitch` with a `FloatLiteral`. This value is the `NoteNumber` value.
     */
    public init(floatLiteral value: Float) {
        self.init(noteNumber: NoteNumber(value))
    }
}

extension Pitch: IntegerLiteralConvertible {
    
    // MARK: - IntegerLiteralConvertible
    
    /**
     Create a `Pitch` with an `IntegerLiteral`. This value is the `NoteNumber` value.
     */
    public init(integerLiteral value: Int) {
        self.init(noteNumber: NoteNumber(Float(value)))
    }
}

extension Pitch: Comparable { }

public func == (lhs: Pitch, rhs: Pitch) -> Bool {
    return lhs.noteNumber == rhs.noteNumber
}

public func < (lhs: Pitch, rhs: Pitch) -> Bool {
    return lhs.noteNumber < rhs.noteNumber
}

extension Pitch: Hashable {
    
    // MARK: - Hashable

    /// Hash value.
    public var hashValue: Int { return noteNumber.hashValue }
}

extension Pitch: CustomStringConvertible {
 
    // MARK: - CustomStringConvertible
    
    /// Printed description.
    public var description: String { return "\(noteNumber)" }
    
}