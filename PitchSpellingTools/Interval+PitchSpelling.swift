//
//  Interval+PitchSpelling.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/19/16.
//
//

import Pitch

extension Interval {
    
    /** 
     `IntervalClass` representation of `Interval`.
     
     - TODO: Move to up `Pitch` framework
    */
    public var intervalClass: IntervalClass { return IntervalClass(self) }
    
    /// Priority for this `Interval` to be spelled. Lower value is higher priority.
    public var spellingPriority: IntervalClass.SpellingPriority? {
        return intervalClass.spellingPriority
    }
}
