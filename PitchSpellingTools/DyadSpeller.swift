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
    
    /**
     Spell with given `dyad` with the pitchSpellings found in the given `pitchSpellingDyad`.

     - throws: `PitchSpelling.Error.invalidSpellingForPitch` if either pitchSpelling in the
     `pitchSpellingDyad` is unfit for the target pitch of the `dyad`.
     */
    public static func spell(dyad: Dyad, with pitchSpellingDyad: PitchSpellingDyad) throws {
        try dyad.spellLower(with: pitchSpellingDyad.lower)
        try dyad.spellHigher(with: pitchSpellingDyad.higher)
    }
    
    /// All possible combinations of `PitchSpellings` of each `Pitch`
    internal let allPitchSpellingDyads: [PitchSpellingDyad]
    
    internal var stepPreservingPitchSpellingDyads: [PitchSpellingDyad] {
        return allPitchSpellingDyads.filter { $0.isStepPreserving }
    }
    
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
    
    // forcibly spell
    public func spell() throws {
        
    }
}
