//
//  QuarterToneDyadSpeller.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/5/16.
//
//

import Pitch

internal class QuarterToneDyadSpeller: HalfToneDyadSpeller {
    
    // priorities:
    // - coarse direction match (sharp, quartersharp; flat, quarterflat)
    // - least distance
    
    internal var coarseMatchingPitchSpellingDyads: [PitchSpellingDyad] {
        return pitchSpellingDyads.filter { $0.isCoarseMatching }
    }
    
    internal var coarseDirectionMatchingPitchSpellingDyads: [PitchSpellingDyad] {
        return pitchSpellingDyads.filter { $0.isCoarseDirectionMatching }
    }
    
    internal override var options: Result {
        
        return .none
    }
}