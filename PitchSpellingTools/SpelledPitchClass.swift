//
//  SpelledPitchClass.swift
//  PitchSpellingTools
//
//  Created by James Bean on 8/20/16.
//
//

import Pitch

/**
 Spelled Pitch Class
 */
public struct SpelledPitchClass {
    
    // MARK: - Instance Properties
    
    /// Pitch class.
    public let pitchClass: PitchClass
    
    /// Spelling.
    public let spelling: PitchSpelling
    
    // MARK: - Initializers
    
    /**
     Create a `SpelledPitchClass` (with argument labels).
     */
    public init(pitchClass: PitchClass, spelling: PitchSpelling) {
        self.pitchClass = pitchClass
        self.spelling = spelling
    }
    
    /**
     Create a `SpelledPitchClass` (without argument labels).
     */
    public init(_ pitchClass: PitchClass, _ spelling: PitchSpelling) {
        self.pitchClass = pitchClass
        self.spelling = spelling
    }
    
    // FIXME: Refine relationship between `PitchSpelling` and `SpelledPitchClass`.
    public init(_ spelling: PitchSpelling) {
        self.spelling = spelling
        self.pitchClass = spelling.pitchClass
    }
}

extension SpelledPitchClass: CustomStringConvertible {
    
    // MARK: - CustromStringConvertible
    
    /// Printed description.
    public var description: String {
        return "\(pitchClass): \(spelling)"
    }
}

extension SpelledPitchClass: Hashable {
    
    // MARK: - Hashable
    
    public var hashValue: Int { return "\(pitchClass)\(spelling)".hashValue }
}

// MARK: - Equatable

public func == (lhs: SpelledPitchClass, rhs: SpelledPitchClass) -> Bool {
    return lhs.pitchClass == rhs.pitchClass && lhs.spelling == rhs.spelling
}

// MARK: - Comparable


/**
 - TODO: Refine.
 */
public func < (lhs: SpelledPitchClass, rhs: SpelledPitchClass) -> Bool {
    return lhs.pitchClass < rhs.pitchClass
}
