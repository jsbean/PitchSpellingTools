//
//  IntervalQualityType.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/11/16.
//
//

import EnumTools

internal protocol IntervalQualityType: EnumTree {
    
    static var diminished: IntervalQuality.EnumKind { get }
    
    static var augmented: IntervalQuality.EnumKind { get }
    
    static var stepPreserving: [IntervalQuality.EnumKind] { get }
    
    static func intervalQuality(fromDirectionDifference difference: Float) -> EnumKind
    
    static func directionDifference(fromPitchSpellingDyad pitchSpellingDyad: PitchSpellingDyad)
        -> Float
    
    static func adjustDifference(difference: Float,
        forLowerPitchSpelling pitchSpelling: PitchSpelling
    ) -> Float
}

extension IntervalQualityType {
    
    static func adjustDifference(difference: Float,
        forLowerPitchSpelling pitchSpelling: PitchSpelling
    ) -> Float
    {
        return difference
    }
    
    static func directionDifference(fromPitchSpellingDyad pitchSpellingDyad: PitchSpellingDyad)
        -> Float
    {
        let lowerDirection = pitchSpellingDyad.lower.coarse.direction.rawValue
        let higherDirection = pitchSpellingDyad.higher.coarse.direction.rawValue
        let difference = (higherDirection - lowerDirection)
        return adjustDifference(difference, forLowerPitchSpelling: pitchSpellingDyad.lower)
    }
}
