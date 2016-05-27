//
//  SpelledPitchSet.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/28/16.
//
//

import Pitch

public struct SpelledPitchSet {
    
    private let pitches: Set<SpelledPitch>
    
    public init(pitches: [SpelledPitch]) {
        self.pitches = Set(pitches)
    }
}

