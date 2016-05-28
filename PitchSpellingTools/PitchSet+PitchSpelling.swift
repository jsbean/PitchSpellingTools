//
//  PitchSet+PitchSpelling.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/26/16.
//
//

import Pitch

extension PitchSet {
    
    public var sortedBySpellingUrgency: [Pitch] {
        return self
            .map { $0 }.lazy
            .sort { $0.pitchClass.spellingUrgency < $1.pitchClass.spellingUrgency }
    }
    
    public func spelledWithDefaultSpellings() throws -> SpelledPitchSet {
        let pitches = try self.map { try $0.spelledWithDefaultSpelling() }
        return SpelledPitchSet(pitches: pitches)
    }
}