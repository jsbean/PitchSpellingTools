//
//  PitchSet+PitchSpelling.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/26/16.
//
//

import Pitch

extension PitchSet {
    
    public var canBeSpelledObjectively: Bool {
        return self.allMatch { $0.canBeSpelledObjectively }
    }
    
    public func spelledWithDefaultSpellings() throws -> SpelledPitchSet {
        return try SpelledPitchSet(self.map { try $0.spelledWithDefaultSpelling() })
    }
}
