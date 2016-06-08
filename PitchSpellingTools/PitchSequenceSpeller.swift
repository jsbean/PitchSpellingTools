//
//  PitchSequenceSpeller.swift
//  PitchSpellingTools
//
//  Created by James Bean on 6/8/16.
//
//

import Pitch

public final class PitchSequenceSpeller {
    
    // cut up sequences
    public lazy var subSequences: [[PitchSet]] = {
        var result: [[PitchSet]] = []
        for set in self.sets {
            if set.canBeSpelledObjectively {
                
            }
        }
        return result
    }()
    
    private let sets: [PitchSet]
    
    public init(sets: [PitchSet]) {
        self.sets = sets
    }
}
