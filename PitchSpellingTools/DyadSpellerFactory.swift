//
//  DyadSpellerFactory.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/5/16.
//
//

import Pitch

internal struct DyadSpellerFactory {
    
    internal static func makeDyadSpeller(forDyad dyad: Dyad) -> DyadSpeller? {
        var classType: DyadSpeller.Type {
            if dyad.hasEighthTone { return EighthToneDyadSpeller.self }
            else if dyad.hasQuarterTone { return QuarterToneDyadSpeller.self }
            else { return HalfToneDyadSpeller.self }
        }
        return classType.init(dyad: dyad)
    }
}