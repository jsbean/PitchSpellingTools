//
//  HalfToneDyadSpeller.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/5/16.
//
//

import Pitch

internal class HalfToneDyadSpeller: DyadSpeller {
    
    /**
     - returns: `DyadSpeller.Result`.
     */
    internal override var options: Result {
        switch stepPreservingPitchSpellingDyads.count {
        case 0:
            return .none
        case 1:
            return .single(stepPreservingPitchSpellingDyads.first!)
        default:
            return .multiple(
                stepPreservingPitchSpellingDyads.sort { $0.meanDistance < $1.meanDistance }
            )
        }
    }
}