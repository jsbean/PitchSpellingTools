//
//  HalfToneDyadSpeller.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/5/16.
//
//

import Pitch

public class HalfToneDyadSpeller: DyadSpeller {
    
    public override func spell() -> Result {
        guard let first = stepPreservingPitchSpellingDyads.first else { fatalError() }
        
        return .none
    }
}