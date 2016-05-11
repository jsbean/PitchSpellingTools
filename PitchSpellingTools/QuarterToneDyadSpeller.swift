//
//  QuarterToneDyadSpeller.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/5/16.
//
//

import Pitch

internal class QuarterToneDyadSpeller: HalfToneDyadSpeller {
    
    internal lazy var coarseMatching: [PitchSpellingDyad] = {
        return self.pitchSpellingDyads.filter { $0.isCoarseMatching }
    }()
    
    internal lazy var coarseDirectionMatching: [PitchSpellingDyad] = {
        return self.pitchSpellingDyads.filter { $0.isCoarseDirectionMatching }
    }()
    
    internal lazy var coarseMatchingAndStepPreserving: [PitchSpellingDyad] = {
        return Array(Set(self.stepPreserving).union(self.coarseMatching))
    }()
    
    internal lazy var coarseDirectionMatchingAndStepPreserving: [PitchSpellingDyad] = {
        return Array(Set(self.stepPreserving).union(self.coarseDirectionMatching))
    }()
    
    /// - warning: Not yet implemented!
    internal override var options: Result {
        
        // check if either or both are spellable objectively
        // - this may actually be quite common: aside from
        // - - c-qtr-flat/b-qtr-sharp and
        // - - f-qtr-flat/e-qtr-sharp
        // - all quarter-step spellings are objective (if we are avoiding 3/4 sharps/flats)
        
        // if both objective: exit with .single(PitchSpellingDyad(obj1, obj2)
        
        // if one objective: filter for PitchSpellingDyads that contain the objective Spelling
        // - priorities:
        // - - first check for stepPreserving:
        // - - - none:
        // - - - single: exit
        // - - - multiple: match stepPreserving ∪ coarseMatching
        
        
        return .none
    }
}