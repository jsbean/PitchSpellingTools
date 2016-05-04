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
        return dyad.lower.pitchSpellings.reduce([]) { accum, lower in
            accum + dyad.higher.pitchSpellings.map { higher in
                PitchSpellingDyad(lower, higher)
            }
        }
    }
    
    private var dyad: Dyad

    public init(dyad: Dyad) {
        self.dyad = dyad
    }
    
    mutating public func spell() {
        // allowed types: Major, Minor, Diminished,
        self.dyad = dyad.spelled()
    }
}