//
//  Pitch+PitchSpelling.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/2/16.
//
//

import Pitch

extension Pitch {
    
    // MARK: - Instance Properties
    
    /**
     `true` for `n	atural` spellable `Pitches`. Otherwise `false`.
     
     ```
     Pitch(noteNumber: 60) // => true (.c, .natural)
     Pitch(noteNumber: 68) // => false (.a, .flat) / (.g, .sharp)
     ```
     */
    public var canBeSpelledObjectively: Bool {
        for spelling in spellings {
            if spelling.coarse == .natural && spelling.fine == .none { return true }
        }
        return false
    }
    
//    public var spellability: Spellability {
//        if let 
//    }
 
    /// All `PitchSpelling` structures available for this `Pitch`.
    public var spellings: [PitchSpelling] {
        return PitchSpellings.spellings(forPitchClass: pitchClass) ?? []
    }
    
    /// - TODO: Encapsulate this logic within `PitchSpellings` `struct`.
    public var spellingsWithoutUnconventionalEnharmonics: [PitchSpelling] {
        var spellings = self.spellings
        
        // c flat
        spellings = spellings.filter {
            !($0.letterName == .c && $0.coarse == .flat)
        }
        
        // f flat
        spellings = spellings.filter {
            !($0.letterName == .f && $0.coarse == .flat)
        }
        
        // e sharp
        spellings = spellings.filter {
            !($0.letterName == .e && $0.coarse == .sharp)
        }
        
        // b sharp
        spellings = spellings.filter {
            !($0.letterName == .b && $0.coarse == .sharp)
        }
        
        // double flats and sharps
        spellings = spellings.filter {
            !($0.coarse == .doubleSharp || $0.coarse == .doubleFlat)
        }
        
        return spellings
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
    
    // MARK: - Instance Methods
    
    /**
     - returns: `SpelledPitch` with the given `PitchSpelling`,
     if the given `PitchSpelling` is valid for the `PitchClass` of the given `pitch`.
    
     - throws: `PitchSpelling.Error.InvalidPitchSpellingForPitch` if the given `spelling` is
     not appropriate for this `Pitch`.
     */
    public func spelled(with spelling: PitchSpelling) throws -> SpelledPitch {
        
        guard spelling.isValid(forPitch: self) else {
            throw PitchSpelling.Error.invalidSpelling(self, spelling)
        }
        
        return SpelledPitch(pitch: self, spelling: spelling)
    }
    
    /**
     - throws: `PitchSpelling.Error` if no default spelling exists for this `Pitch`.
     
     - returns: `SpelledPitch` with the default spelling for this `Pitch`, if possible.
     */
    public func spelledWithDefaultSpelling() throws -> SpelledPitch {
        guard let defaultSpelling = defaultSpelling else {
            throw PitchSpelling.Error.noSpellingForPitch(self)
        }
        
        return try spelled(with: defaultSpelling)
    }
}