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
        return [higher.resolution, lower.resolution].minElement()!
    }

    /// The degree to which a `Dyad` can be spelled.
    public var spellability: Spellability {
        if lower.canBeSpelledObjectively && higher.canBeSpelledObjectively {
            return .objective
        } else if !lower.canBeSpelledObjectively && !higher.canBeSpelledObjectively {
            return .fullyAmbiguous
        } else {
            return .semiAmbiguous
        }
    }

    /** 
     - returns: A tuple containing the `Pitch` value contained herein that has a `spellability`
        value of `.objective`, followed by the `Pitch` value contained herein that does not, 
        if this `Dyad` has a `spellability` value of `.semiObjective`. Otherwise, `nil`.
    */
    public var objectivelySpellableAndNot: (Pitch, Pitch)? {
        guard spellability == .semiAmbiguous else { return nil }
        return lower.canBeSpelledObjectively && !higher.canBeSpelledObjectively
            ? (lower, higher)
            : (higher, lower)
    }
}
