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
    private var allPitchSpellingDyads: [PitchSpellingDyad] { return [] }
    
    private let dyad: Dyad

    public init(dyad: Dyad) {
        self.dyad = dyad
    }
    
    // spell all with default spellings (F# not Gb, even if F natural, etc.)
    
    // spell those that can be spelled objectively
    
    
}