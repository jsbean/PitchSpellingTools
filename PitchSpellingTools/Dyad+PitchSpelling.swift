//
//  Dyad+PitchSpelling.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/3/16.
//
//

import Pitch

extension Dyad {
    
    public var canBeSpelledObjectively: Bool {
        return lower.canBeSpelledObjectively && higher.canBeSpelledObjectively
    }
    
    public func spelledWithDefaultSpellings() -> Dyad {
        print("spelled with defaults")
        return Dyad(
            SpelledPitch(pitch: lower, spelling: lower.defaultPitchSpelling),
            SpelledPitch(pitch: higher, spelling: higher.defaultPitchSpelling)
        )
    }
}