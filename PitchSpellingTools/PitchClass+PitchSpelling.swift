//
//  PitchClass+PitchSpelling.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/26/16.
//
//

import Pitch

extension PitchClass {
    
    public var spellingPriority: Int? {
        return IntervalClass(self.value).spellingPriority
    }
}