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
    
    /// - warning: Not yet implemented!
    public var allPitchSpellingDyads: [PitchSpellingDyad] {
        var result: [PitchSpellingDyad] = []
        for lower in dyad.lower.pitchSpellings {
            for higher in dyad.higher.pitchSpellings {
                result.append(PitchSpellingDyad(lower, higher))
            }
        }
        return result
        /*
        return dyad.lower.pitchSpellings.reduce([]) { accum, lower in
            dyad.higher.pitchSpellings.map { higher in
                PitchSpellingDyad(lower, higher)
            }
        }
        */
        
        /*
        dyad.lower.pitchSpellings.forEach { lower in
            dyad.higher.pitchSpellings.forEach { higher in
                result.append(PitchSpellingDyad(lower, higher))
            }
        }
        */
    }
    
    private var dyad: Dyad

    public init(dyad: Dyad) {
        self.dyad = dyad
    }
    
    mutating public func spell() {
        self.dyad = dyad.spelled()
    }
    
    // spell all with default spellings (F# not Gb, even if F natural, etc.)
    
    // spell those that can be spelled objectively
    
    
}