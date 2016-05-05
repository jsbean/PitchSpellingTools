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
    
    private var dyad: Dyad

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
        return dyad.canBeSpelledObjectively ? dyad.spelledWithDefaultSpellings() : dyad
    }
}
