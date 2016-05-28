//
//  Dyad+PitchSpelling.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/3/16.
//
//

import Pitch

extension Dyad {
    
    public enum Error: ErrorType {
        case pitchNotFound
        case cannotSpellPitches
    }
    
    public var hasEighthTone: Bool {
        return higher.resolution == 0.25 || lower.resolution == 0.25
    }
    
    public var hasQuarterTone: Bool {
        return higher.resolution == 0.5 || lower.resolution == 0.5
    }
    
    public var finestResolution: Float {
        return [higher.resolution, lower.resolution].minElement()!
    }

    public var canBeSpelledObjectively: Bool {
        return lower.canBeSpelledObjectively && higher.canBeSpelledObjectively
    }
    
    public var isFullyAmbiguouslySpellable: Bool {
        return !lower.canBeSpelledObjectively && !higher.canBeSpelledObjectively
    }
    
    public var isSemiAmbiguouslySpellable: Bool {
        return (
            (lower.canBeSpelledObjectively && !higher.canBeSpelledObjectively) ||
            (!lower.canBeSpelledObjectively && higher.canBeSpelledObjectively)
        )
    }
    
    public var defaultSpellingDyad: PitchSpellingDyad? {
        
        guard let lowerSpelling = lower.defaultSpelling,
            higherSpelling = higher.defaultSpelling
        else {
            return nil
        }
        
        return PitchSpellingDyad(lowerSpelling, higherSpelling)
    }
    
    public var objectivelySpellableAndNot: (Pitch, Pitch)? {
        guard isSemiAmbiguouslySpellable else { return nil }
        return lower.canBeSpelledObjectively && !higher.canBeSpelledObjectively
            ? (lower, higher)
            : (higher, lower)
    }
    
    public func spellWithDefaultSpellings() throws -> SpelledDyad {
        
        guard let defaultSpellingDyad = defaultSpellingDyad else {
            throw Error.cannotSpellPitches
        }
        
        return try spell(with: defaultSpellingDyad)
    }
    
    public func spell(with spellingDyad: PitchSpellingDyad) throws -> SpelledDyad {
        return SpelledDyad(
            higher: try spellHigher(with: spellingDyad.a),
            lower: try spellLower(with: spellingDyad.b)
        )
    }
    
    internal func spellHigher(with spelling: PitchSpelling) throws -> SpelledPitch {
        return try higher.spelled(with: spelling)
    }
    
    internal func spellLower(with spelling: PitchSpelling) throws -> SpelledPitch {
        return try lower.spelled(with: spelling)
    }
}
