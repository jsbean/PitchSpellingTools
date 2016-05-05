//
//  Dyad+PitchSpelling.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/3/16.
//
//

import Pitch

extension Dyad {
    
    public var hasEighthTone: Bool {
        return higher.resolution == 0.25 || lower.resolution == 0.25
    }
    
    public var hasQuarterTone: Bool {
        return higher.resolution == 0.5 || lower.resolution == 0.5
    }
    
    public var canBeSpelledObjectively: Bool {
        return lower.canBeSpelledObjectively && higher.canBeSpelledObjectively
    }
    
    public func spelledWithDefaultSpellings() -> Dyad {
        return Dyad(
            SpelledPitch(pitch: lower, spelling: lower.defaultPitchSpelling),
            SpelledPitch(pitch: higher, spelling: higher.defaultPitchSpelling)
        )
    }
}