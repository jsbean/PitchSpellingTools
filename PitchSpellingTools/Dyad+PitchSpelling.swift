//
//  Dyad+PitchSpelling.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/3/16.
//
//

import Pitch

extension Dyad {
    
    /// - returns: `true` if either `Pitch` value contained herein has a resolution of `0.25`
    public var hasEighthTone: Bool {
        return higher.resolution == 0.25 || lower.resolution == 0.25
    }
    
    /// - returns: `true` if either `Pitch` value contained herein has a resolution of `0.50`
    public var hasQuarterTone: Bool {
        return higher.resolution == 0.5 || lower.resolution == 0.5
    }
    
    /// Finest resolution of the `Pitch` values contained herein.
    public var finestResolution: Float {
        return [higher.resolution, lower.resolution].min()!
    }
}
