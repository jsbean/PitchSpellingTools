//
//  SpelledPitch.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/1/16.
//
//

import Pitch

/**
 Structure that extends a `Pitch` with a `PitchSpelling`.
 */
public class SpelledPitch: Pitch {
    
    private let spelling: PitchSpelling
    
    /**
     Create a `SpelledPitch` with a given `pitch` and `spelling`.
     */
    public init(pitch: Pitch, spelling: PitchSpelling) {
        self.spelling = spelling
        super.init(pitch: pitch)
    }
    
    public override var description: String {
        return "\(super.description): \(spelling)"
    }
}
