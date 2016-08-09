//
//  PerfectIntervalQualityType.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/11/16.
//
//

import ArithmeticTools

/// Definition of perfect interval quality types
internal protocol PerfectIntervalQualityType: IntervalQualityType {
    
    /// Perfect interval quality type.
    static var perfect: IntervalQuality.EnumKind { get }
    
    static func kind(normalizedIntervalClass intervalClass: Float) -> IntervalQuality.EnumKind
}

extension PerfectIntervalQualityType {
    
    /// Members that are available to perfect interval quality types
    static var perfectMembers: [IntervalQuality.EnumKind] {
        return [doubleDiminished, diminished, perfect, augmented, doubleAugmented]
    }
    
    static func kind(normalizedIntervalClass intervalClass: Float) -> IntervalQuality.EnumKind {
        switch intervalClass {
        case 0: return perfect
        case +1: return augmented
        case -1: return diminished
        case _ where intervalClass > 1: return doubleAugmented
        case _ where intervalClass < -1: return doubleDiminished
        default: fatalError("bad number")
        }
    }
    
    // FIXME: -3, 3 coming up is the signal that something is not right
    // TODO: Remove when possible
    static func intervalQuality(fromDirectionDifference difference: Float)
        -> IntervalQuality.EnumKind
    {
        
        switch difference {
        case -2, -3: return doubleDiminished
        case -1: return diminished
        case +0: return perfect
        case +1: return augmented
        case +2, 3: return doubleAugmented
        default:
            fatalError("Such an interval couldn't possibly exist: \(difference), yet")
        }
    }
    
    // TODO: Remove when possible
    static func adjustDifference(difference: Float,
        forLowerPitchSpelling pitchSpelling: PitchSpelling
    ) -> Float
    {
        return pitchSpelling.letterName == .b ? difference - 1 : difference
    }
}
