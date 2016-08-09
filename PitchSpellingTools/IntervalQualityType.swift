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
    
    static func kind(normalizedIntervalClass intervalClass: Float) -> IntervalQuality.EnumKind
    
    static func intervalQuality(fromDirectionDifference difference: Float) -> EnumKind
    
//    // TODO: Remove when possible
//    static func directionDifference(fromPitchSpellingDyad pitchSpellingDyad: PitchSpellingDyad)
//        -> Float
//    
//    // TODO: Remove when possible
//    static func adjustDifference(difference: Float,
//        forLowerPitchSpelling pitchSpelling: PitchSpelling
//    ) -> Float
}

extension IntervalQualityType {
    
//    // TODO: remove when possible
//    static func adjustDifference(difference: Float,
//        forLowerPitchSpelling pitchSpelling: PitchSpelling
//    ) -> Float
//    {
//        return difference
//    }
//    
//    static func directionDifference(fromPitchSpellingDyad pitchSpellingDyad: PitchSpellingDyad)
//        -> Float
//    {
//        let lowerDirection = pitchSpellingDyad.b.coarse.direction.rawValue
//        let higherDirection = pitchSpellingDyad.a.coarse.direction.rawValue
//        let difference = (higherDirection - lowerDirection)
//        return adjustDifference(difference, forLowerPitchSpelling: pitchSpellingDyad.b)
//    }
}
