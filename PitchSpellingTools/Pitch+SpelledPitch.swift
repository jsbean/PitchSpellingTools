//
//  Pitch+SpelledPitch.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/1/16.
//
//

import Foundation
import Pitch

extension Pitch {
    
    // MARK: - Spelling
    
    /**
     - returns: `SpelledPitch` with the given `PitchSpelling`, 
     if the given `PitchSpelling` is valid for the `PitchClass` of the given `pitch`,
     Otherwise `nil`.
     */
    public func spell(withPitchSpelling spelling: PitchSpelling) -> SpelledPitch? {
        return SpelledPitch(pitch: self, spelling: spelling)
    }
}