//
//  PitchSet+PitchSpelling.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/26/16.
//
//

import Pitch

extension PitchSet {

    // MARK: PitchSpelling
    
    /// The degree to which a `PitchSet` can be spelled.
    public var spellability: Spellability {
        if isEmpty || self.allSatisfy({ $0.canBeSpelledObjectively }) {
            return .objective
        } else if anySatisfy({ $0.canBeSpelledObjectively }) {
            return .semiAmbiguous
        } else {
            return .fullyAmbiguous
        }
    }
    
    /**
     - throws: `PitchSpelling.Error` if any `Pitch` values herein cannot be spelled with
     current technology.
     
     - returns: `SpelledPitchSet` containing `SpelledPitch` values for each `Pitch` value
     contained herein.
     */
    public func spelledWithDefaultSpellings() throws -> SpelledPitchSet {
        return try SpelledPitchSet(self.map { try $0.spelledWithDefaultSpelling() })
    }
}
