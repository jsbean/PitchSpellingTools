//
//  SpelledPitchSet.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/28/16.
//
//

import Pitch

/**
 Unordered set of unique `SpelledPitch` values.
 */
public struct SpelledPitchSet {
    
    private let pitches: Set<SpelledPitch>
    
    // MARK: - Initializers
    
    /**
     Create a `SpelledPitchSet` with an array of `SpelledPitch` values.
     */
    public init(pitches: [SpelledPitch]) {
        self.pitches = Set(pitches)
    }
}

extension SpelledPitchSet: SequenceType {
    
    /// Generate `Pitches` for iteration.
    public func generate() -> AnyGenerator<SpelledPitch> {
        var generator = pitches.generate()
        return AnyGenerator { return generator.next() }
    }
}

extension SpelledPitchSet: Equatable { }

public func == (lhs: SpelledPitchSet, rhs: SpelledPitchSet) -> Bool {
    return lhs.pitches == rhs.pitches
}