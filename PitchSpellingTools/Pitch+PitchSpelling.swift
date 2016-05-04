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
}