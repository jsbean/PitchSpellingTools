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
    // - step preserving
    // - coarse direction match (sharp, quartersharp; flat, quarterflat)
    // - least distance (d nat, )
    
    internal var coarseMatching: [PitchSpellingDyad] {
        return pitchSpellingDyads.filter { $0.isCoarseMatching }
    }
    
    internal var coarseDirectionMatching: [PitchSpellingDyad] {
        return pitchSpellingDyads.filter { $0.isCoarseDirectionMatching }
    }
    
    internal var coarseMatchingAndStepPreserving: [PitchSpellingDyad] {
        return Array(Set(stepPreserving).union(coarseMatching))
    }
    
    internal var coarseDirectionMatchingAndStepPreserving: [PitchSpellingDyad] {
        return Array(Set(stepPreserving).union(coarseDirectionMatching))
    }
    
    internal override var options: Result {
        switch stepPreserving.count {
        case 0:
            return .none // refine ...
            // fall back to ...
            // c ctr sharp
            //
        case 1:
            return .single(stepPreserving.first!)
        default:
            break
            // further refine
        }
        
        
        return .none
    }
}