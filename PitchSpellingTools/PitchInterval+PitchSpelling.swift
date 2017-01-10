//
//  PitchInterval+PitchSpelling.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/19/16.
//
//

import Pitch

extension PitchInterval {
    
    /** 
     `IntervalClass` representation of `Interval`.
     
     - TODO: Move to up `Pitch` framework
    */
    public var intervalClass: PitchClassInterval {
        return PitchClassInterval(self)
    }
    
    /// Priority for this `Interval` to be spelled. Lower value is higher priority.
    public var spellingPriority: PitchClassInterval.SpellingPriority? {
        return intervalClass.spellingPriority
    }
}
