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
    
    public func spellWithDefaultSpellings() throws {
        guard let lowerSpelling = lower.defaultSpelling,
            higherSpelling = higher.defaultSpelling
        else {
            throw Error.cannotSpellPitches
        }
        try spellLower(with: lowerSpelling)
        try spellHigher(with: higherSpelling)
    }
    
    public func spellHigher(with spelling: PitchSpelling) throws {
        try higher.spell(with: spelling)
    }
    
    public func spellLower(with spelling: PitchSpelling) throws {
        try lower.spell(with: spelling)
    }
}