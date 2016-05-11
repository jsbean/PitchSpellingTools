//
//  Pitch+PitchSpelling.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/2/16.
//
//

import Pitch

extension Pitch {
    
    /**
     `true` if only one `PitchSpelling` exists for this `Pitch`. Otherwise `false`.
     
     >`Pitch(noteNumber: 60) // => true (.c, .natural)`
     >`Pitch(noteNumber: 68) // => false (.a, .flat) / (.g, .sharp)`
     */
    public var canBeSpelledObjectively: Bool { return spellings.count == 1 }
 
    /// All `PitchSpelling` structures available for this `Pitch`.
    public var spellings: [PitchSpelling] {
        return PitchSpellings.spellings(forPitchClass: pitchClass) ?? []
    }
    
    /// The first available `PitchSpelling` for this `Pitch`, if present. Otherwise `nil`.
    public var defaultSpelling: PitchSpelling? {
        return PitchSpellings.defaultSpelling(forPitchClass: pitchClass)
    }
    
    /**
     Fineness of `Pitch`.
     - 1.00: half-tone (e.g., c natural, g sharp, etc.)
     - 0.50: quarter-tone (e.g., c quarterShap, g quarterFlat, etc.)
     - 0.25: eighth-tone (e.g., c natural up, q quarterflat down, etc.)
     
     - TODO: make `throw` in the case of a strange resolution (e.g., 60.81356)
     */
    public var resolution: Float {
        if noteNumber.value % 1.0 == 0.0 { return 1.0 }
        else if noteNumber.value % 0.5 == 0.0 { return 0.5 }
        else if noteNumber.value % 0.25 == 0.0 { return 0.25 }
        return 0.0
    }
    
    /**
     - returns: `SpelledPitch` with the given `PitchSpelling`,
     if the given `PitchSpelling` is valid for the `PitchClass` of the given `pitch`.
    
     - throws: `PitchSpelling.Error.InvalidPitchSpellingForPitch` if the given `spelling` is
     not appropriate for this `Pitch`.
     */
    public func spell(with spelling: PitchSpelling) throws -> SpelledPitch {
        
        guard spelling.isValid(forPitch: self) else {
            throw PitchSpelling.Error.invalidSpelling(self, spelling)
        }
        
        return SpelledPitch(pitch: self, spelling: spelling)
    }
}