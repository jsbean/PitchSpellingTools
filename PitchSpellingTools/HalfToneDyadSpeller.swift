//
//  HalfToneDyadSpeller.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/5/16.
//
//

import Pitch

internal class HalfToneDyadSpeller: DyadSpeller {
    
    internal var stepPreserving: [PitchSpellingDyad] {
        return pitchSpellingDyads.filter { $0.isStepPreserving }
    }
    
    /**
     - returns: `DyadSpeller.Result`.
     */
    internal override var options: Result {
        switch stepPreserving.count {
        case 0:
            return .none
        case 1:
            return .single(stepPreserving.first!)
        default:
            return .multiple(
                stepPreserving.sort { $0.meanSpellingDistance < $1.meanSpellingDistance }
            )
        }
    }
}