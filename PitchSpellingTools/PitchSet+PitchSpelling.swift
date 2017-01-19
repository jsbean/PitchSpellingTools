//
//  PitchSet+PitchSpelling.swift
//  PitchSpellingTools
//
//  Created by James Bean on 1/19/17.
//
//

import Pitch

extension PitchSet {
    
    /// - returns: A `SpelledPitchSet` with the values of self spelled with the default
    /// `PitchSpelling` value.
    public func spelledWithDefaultSpelling() -> SpelledPitchSet {
        return SpelledPitchSet(map { $0.spelledWithDefaultSpelling() })
    }
}
