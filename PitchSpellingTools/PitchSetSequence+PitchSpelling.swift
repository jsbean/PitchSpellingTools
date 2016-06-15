//
//  PitchSetSequence+PitchSpelling.swift
//  PitchSpellingTools
//
//  Created by James Bean on 6/9/16.
//
//

import ArrayTools
import Pitch

extension PitchSetSequence {
    
    public var spellability: Spellability {
        
        // not sure why i have to cast this here?
        if allSatisfy({ ($0 as PitchSet).spellability == .objective }) {
            return .objective
        } else if anySatisfy({ ($0 as PitchSet).spellability == .objective }) {
            return .semiAmbiguous
        } else {
            return .fullyAmbiguous
        }
    }
}