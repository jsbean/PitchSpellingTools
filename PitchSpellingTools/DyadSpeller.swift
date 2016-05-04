//
//  DyadSpeller.swift
//  Pitch
//
//  Created by James Bean on 3/17/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import Pitch

/**
 - warning: Not yet implemented!
 */
public struct DyadSpeller: PitchSpeller {
    
    /// All possible combinations of `PitchSpellings` of each `Pitch`
    public var allPitchSpellingDyads: [PitchSpellingDyad] {
        return dyad.lower.pitchSpellings.reduce([]) { accum, lo in
            accum + dyad.higher.pitchSpellings.map { hi in PitchSpellingDyad(lo, hi) }
        }
    }
    
    private var dyad: Dyad

    public init(dyad: Dyad) {
        self.dyad = dyad
    }
    
    mutating public func spell() {
        if dyad.canBeSpelledObjectively { dyad = dyad.spelledWithDefaultSpellings() }
    }
}
