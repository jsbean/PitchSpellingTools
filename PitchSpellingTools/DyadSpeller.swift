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
    
    /// All possible combinations of `PitchSpellings` of each `Pitch`
    public let allPitchSpellingDyads: [PitchSpellingDyad]
    
    public var stepPreservingPitchSpellingDyads: [PitchSpellingDyad] {
        return allPitchSpellingDyads.filter { $0.isStepPreserving }
    }
    
    internal var dyad: Dyad
    
    /**
     Make a `DyadSpeller` of the best-suited subclass for the given `dyad`.
     */
    public static func makeSpeller(forDyad dyad: Dyad) -> DyadSpeller? {
        return DyadSpellerFactory.makeSpeller(forDyad: dyad)
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
     - warning: Not yet implemented!
     */
    public func spell() -> Dyad {
        print("allPitchSpellingDyads:")
        allPitchSpellingDyads.forEach { print($0) }
        print("step preserving:")
        stepPreservingPitchSpellingDyads.forEach { print($0) }
        
        return dyad.canBeSpelledObjectively ? dyad.spelledWithDefaultSpellings() ?? dyad : dyad
    }
}
