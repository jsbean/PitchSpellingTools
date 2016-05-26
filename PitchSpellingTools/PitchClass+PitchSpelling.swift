//
//  PitchClass+PitchSpelling.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/26/16.
//
//

import Pitch

extension PitchClass {
    
    public var spellingComplexity: Int? {
        return IntervalClass(self.value).spellingComplexity
    }
}