//
//  DyadSpellerFactory.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/5/16.
//
//

import Pitch

internal struct DyadSpellerFactory {
    
    internal static func makeSpeller(for dyad: Dyad) -> DyadSpeller? {
        var classType: DyadSpeller.Type? {
            switch dyad.finestResolution {
            case 0.25: return EighthToneDyadSpeller.self
            case 0.5: return QuarterToneDyadSpeller.self
            case 1.0: return HalfToneDyadSpeller.self
            default: return nil
            }
        }
        return classType?.init(dyad: dyad)
    }
}