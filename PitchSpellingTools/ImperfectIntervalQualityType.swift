//
//  ImperfectIntervalQualityType.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/11/16.
//
//

import EnumTools

/// Definition of imperfect interval quality types.
internal protocol ImperfectIntervalQualityType: IntervalQualityType {
    
    /// Major interval quality type.
    static var major: IntervalQuality.EnumKind { get }
    
    /// Minor interval quality type.
    static var minor: IntervalQuality.EnumKind { get }
    
    static func kind(normalizedIntervalClass intervalClass: Float) -> IntervalQuality.EnumKind
}

extension ImperfectIntervalQualityType {
    
    /// Members that are available to imperfect interval quality types.
    static var imperfectMembers: [IntervalQuality.EnumKind] {
        return [doubleDiminished, diminished, minor, major, augmented, doubleAugmented]
    }
    
    /// The imperfect interval quality types that preserve step.
    static var stepPreserving: [IntervalQuality.EnumKind] { return [minor, major] }

    // TODO: flesh out
    static func kind(normalizedIntervalClass intervalClass: Float) -> IntervalQuality.EnumKind {
        switch intervalClass {
        case +0.5: return major
        case -0.5: return minor
        case +1: return augmented
        case -1: return diminished
        case _ where intervalClass > +1: return doubleAugmented
        case _ where intervalClass < -1: return doubleDiminished
        default: fatalError("bad number")
        }
    }
    
    /**
     Ensures that interval qualities are correct for all intervals
     
     - TODO: Remove when possible
     */
    static func adjustDifference(difference: Float,
        forLowerPitchSpelling pitchSpelling: PitchSpelling
    ) -> Float
    {
        return [.d, .e, .a, .b,].contains(pitchSpelling.letterName)
            ? difference - 1
            : difference
    }
    
    // TODO: Remove when possible
    static func intervalQuality(fromDirectionDifference difference: Float)
        -> IntervalQuality.EnumKind
    {
        switch difference {
        case -3: return doubleDiminished
        case -2: return diminished
        case -1: return minor
        case +0: return major
        case +1: return augmented
        case +2: return doubleAugmented
        default: fatalError("Such an interval couldn't possibly exist")
        }
    }
}
