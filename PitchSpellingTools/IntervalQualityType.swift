//
//  IntervalQualityType.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/11/16.
//
//

import EnumTools

/// Type of interval qualities.
internal protocol IntervalQualityType: EnumTree {
    
    /// Double Diminished.
    static var doubleDiminished: IntervalQuality.EnumKind { get }
    
    /// Diminished.
    static var diminished: IntervalQuality.EnumKind { get }
    
    /// Augmented.
    static var augmented: IntervalQuality.EnumKind { get }
    
    /// DoubleAugmented.
    static var doubleAugmented: IntervalQuality.EnumKind { get }
    
    /// Array of `IntervalQualityType` values that preserve `step`.
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
