//
//  Pitch+PitchSpelling.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/2/16.
//
//

import Pitch

extension Pitch {
    
    public var canBeSpelledObjectively: Bool { return pitchSpellings.count == 1 }
    
    public var pitchSpellings: [PitchSpelling] {
        return PitchSpellings.spellings(forPitchClass: pitchClass)!
    }
    
    public var defaultPitchSpelling: PitchSpelling {
        return PitchSpellings.defaultSpelling(forPitchClass: pitchClass)!
    }
    
    public var resolution: Float {
        return noteNumber % 1 == 0 ? 1.0 : noteNumber % 0.5 == 0 ? 0.5 : 0.25
    }
}