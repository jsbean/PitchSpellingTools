//
//  DyadSpeller.swift
//  Pitch
//
//  Created by James Bean on 3/17/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import ArrayTools
import Pitch

/**
 - warning: Not yet implemented!
 */
public class DyadSpeller: PitchSpeller {

    public enum Error: ErrorType { case error } // refine
    
    public enum Result {
        case none
        case single(PitchSpellingDyad)
        case multiple([PitchSpellingDyad])
    }
    
    /// All possible combinations of `PitchSpellings` of each `Pitch`
    internal let allPitchSpellingDyads: [PitchSpellingDyad]
    
    internal var stepPreservingPitchSpellingDyads: [PitchSpellingDyad] {
        return allPitchSpellingDyads.filter { $0.isStepPreserving }
    }
    
    /// - warning: default implementation is `.none`. Must be overriden
    public var options: Result {
        return .none
    }
    
    internal var dyad: Dyad
    
    /**
     Make the best-suited subclass of `DyadSpeller` for the given `dyad`.
     */
    public static func makeSpeller(for dyad: Dyad) -> DyadSpeller? {
        return DyadSpellerFactory.makeSpeller(for: dyad)
    }

    /**
     Create a `DyadSpeller` for the given `dyad`.
     */
    public required init(dyad: Dyad) {
        self.dyad = dyad
        self.allPitchSpellingDyads = combinations(
            dyad.lower.pitchSpellings,
            dyad.higher.pitchSpellings
        ).map { PitchSpellingDyad($0.0, $0.1) }
    }
    
    /**
     Spell the pitches in `dyad` with their default spellings. Often in the case that there is
     no hope to spell the pitches agreeably.
     
     - throws: `PitchSpelling.Error` in the case the pitches in `dyad` are currently 
     unspellable.
     */
    public func spellWithDefaultSpellings() throws {
        try dyad.spellWithDefaultSpellings()
    }
    
    /**
     Spell `dyad` with the pitchSpellings found in the given `pitchSpellingDyad`.
     
     - throws: `PitchSpelling.Error.invalidSpellingForPitch` if either pitchSpelling in the
     `pitchSpellingDyad` is unfit for the target pitch of `dyad`.
     */
    public func spell(with pitchSpellingDyad: PitchSpellingDyad) throws {
        try dyad.spellLower(with: pitchSpellingDyad.lower)
        try dyad.spellHigher(with: pitchSpellingDyad.higher)
    }
    
    /**
     Forcibly spell the pitches in `dyad`. In the case that no options are available wherein
     the pitches in `dyad` can be spelled amicably, the pitches are spelled with the default
     values. In the case that there are more than one options available wherein the pitches
     can be spelled amicably, the `PitchSpellingDyad` with the least `meanDistance` value is
     chosen.
     
     - throws: `PitchSpeller.Error` if
     */
    public func spell() throws {
        switch options {
        case .none:
            try spellWithDefaultSpellings()
        case .single(let pitchSpellingDyad):
            try spell(with: pitchSpellingDyad)
        case .multiple(let pitchSpellingDyads):
            try spell(with: pitchSpellingDyads.first!)
        }
    }
}
