//
//  PitchSet+PitchSpelling.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/26/16.
//
//

import Pitch

extension PitchSet {
    
    public var sortedBySpellingComplexity: [Pitch] {
        return self
            .map { $0 }.lazy
            .sort { $0.pitchClass.spellingComplexity < $1.pitchClass.spellingComplexity }
    }
}