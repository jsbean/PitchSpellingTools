//
//  PitchClass+PitchSpelling.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/26/16.
//
//

import Pitch

extension PitchClass {
    
    public var spellings: [PitchSpelling] {
        return PitchSpellings.spellings(forPitchClass: self) ?? []
    }
    
    /// Spelling priority of a `PitchClass`. Lower values indicate higher priority.
    public var spellingPriority: Int? {
        return IntervalClass(self.value).spellingPriority
    }
}