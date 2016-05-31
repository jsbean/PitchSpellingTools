//
//  SpelledPitchSet.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/28/16.
//
//

import Pitch

public struct SpelledPitchSet: SequenceType {
    
    private let pitches: Set<SpelledPitch>
    
    public init(pitches: [SpelledPitch]) {
        self.pitches = Set(pitches)
    }
    
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