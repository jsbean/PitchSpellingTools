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
        return PitchSpellings.spellings(forPitchClass: pitchClass) ?? []
    }
    
    public var defaultPitchSpelling: PitchSpelling? {
        return PitchSpellings.defaultSpelling(forPitchClass: pitchClass)
    }
    
    public var resolution: Float {
        if noteNumber % 1 == 0 { return 1.0 }
        else if noteNumber % 0.5 == 0 { return 0.5 }
        else if noteNumber % 0.25 == 0 { return 0.25 }
        return 0
    }
    
    /**
     - returns: `SpelledPitch` with the given `PitchSpelling`,
     if the given `PitchSpelling` is valid for the `PitchClass` of the given `pitch`.
    
     - throws: `PitchSpelling.Error.InvalidPitchSpellingForPitch` if the given `spelling` is
     is not appropriate for this `Pitch`.
     */
    public func spell(with spelling: PitchSpelling) throws -> SpelledPitch {
        
        guard spelling.isValid(for: self) else {
            throw PitchSpelling.Error.invalidSpellingForPitch(self, spelling)
        }
        
        return SpelledPitch(pitch: self, spelling: spelling)
    }
}