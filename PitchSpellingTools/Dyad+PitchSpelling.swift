//
//  Dyad+PitchSpelling.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/3/16.
//
//

import Pitch

extension Dyad {
    
    public var canBeSpelledObjectively: Bool {
        return lower.canBeSpelledObjectively && higher.canBeSpelledObjectively
    }
    
    // TODO / FIXME
    public func spelled() -> Dyad {
        return Dyad(
            SpelledPitch(pitch: self.lower, spelling: PitchSpelling(.c)),
            SpelledPitch(pitch: self.higher, spelling: PitchSpelling(.c))
        )
    }
}