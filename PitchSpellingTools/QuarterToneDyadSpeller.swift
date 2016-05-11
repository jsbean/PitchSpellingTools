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
    
    // find a way to do this so it is not just a chain of matches
    
    /// - warning: Not yet implemented!
    internal override var options: Result {
        switch spellability {
        case .both: return .single(dyad.defaultSpellingDyad!)
        case .neither: break
        case .one: break
        }
        
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
    
    // TODO: refactor
    private var spellability: ObjectiveSpellability {
        if dyad.canBeSpelledObjectively { return .both }
        else if dyad.lower.canBeSpelledObjectively && !dyad.higher.canBeSpelledObjectively {
            return .one(objective: dyad.lower, subjective: dyad.higher)
        } else if !dyad.lower.canBeSpelledObjectively && dyad.higher.canBeSpelledObjectively {
            return .one(objective: dyad.higher, subjective: dyad.lower)
        } else {
            return .neither
        }
    }
}
