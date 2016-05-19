//
//  PitchSetSpeller.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/17/16.
//
//

import ArrayTools
import Pitch

/**
 Spells `PitchSet` values.
 */
public struct PitchSetSpeller: PitchSpeller {
    
    private let pitchSet: PitchSet
    
    // sort dyads by spelling complexity
    
    public init(pitchSet: PitchSet) {
        self.pitchSet = pitchSet
    }
}