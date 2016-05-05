//
//  Pitch.swift
//  Pitch
//
//  Created by James Bean on 3/12/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import Foundation

/**
 Subjective psychoacoustical attribute of sound allowing ordering on a frequency-related scale.
 */
public class Pitch: CustomStringConvertible {
    
    // MARK - Type Properties
    
    /// Middle C.
    public static let MiddleC = Pitch(noteNumber: 60)
    
    // MARK: - Instance Properties
    
    public var description: String { return "\(noteNumber)" }
    
    /// `NoteNumber` representation of `Pitch`.
    public let noteNumber: NoteNumber
    
    /// `Frequency` representation of `Pitch`.
    public let frequency: Frequency
    
    /// Modulo 12 representation of `NoteNumber` representation of `Pitch`.
    public var pitchClass: PitchClass { return PitchClass(self) }
    
    // MARK: - Initializers
    
    /**
     Create a `Pitch` with a `NoteNumber` value.
     */
    public init(noteNumber: NoteNumber) {
        self.noteNumber = noteNumber
        self.frequency = Frequency(noteNumber: noteNumber)
    }
    
    /**
     Create a `Pitch` with a `Frequency` value.
     */
    public init(frequency: Frequency) {
        self.frequency = frequency
        self.noteNumber = NoteNumber(frequency: frequency)
    }
    
    /**
     Create a `Pitch` with another `Pitch`.
     */
    public init(pitch: Pitch) {
        self.frequency = pitch.frequency
        self.noteNumber = NoteNumber(frequency: pitch.frequency)
    }
}

extension Pitch: Equatable { }

public func == (lhs: Pitch, rhs: Pitch) -> Bool {
    return lhs.noteNumber == rhs.noteNumber
}

extension Pitch: Comparable { }

public func < (lhs: Pitch, rhs: Pitch) -> Bool {
    return lhs.noteNumber < rhs.noteNumber
}