//
//  Interval+PitchSpelling.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/19/16.
//
//

import Pitch

extension Interval {
    
    /// `IntervalClass` representation of `Interval`.
    public var intervalClass: IntervalClass { return IntervalClass(self) }
    
    public var complexity: IntervalClass.SpellingComplexity? {
        return intervalClass.complexity
    }
}