//
//  PitchSet+PitchSpelling.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/26/16.
//
//

import Pitch

extension PitchSet {
    
    
    public var spellability: Spellability {
        
        if isEmpty || self.allSatisfy({ $0.canBeSpelledObjectively }) {
            return .objective
        } else if anySatisfy({ $0.canBeSpelledObjectively }) {
            return .semiAmbiguous
        } else {
            return .fullyAmbiguous
        }
    }
    
    public func spelledWithDefaultSpellings() throws -> SpelledPitchSet {
        return try SpelledPitchSet(self.map { try $0.spelledWithDefaultSpelling() })
    }
}
