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
}

extension PerfectIntervalQualityType {
    
    /// Members that are available to perfect interval quality types
    static var perfectMembers: [IntervalQuality.EnumKind] {
        return [doubleDiminished, diminished, perfect, augmented, doubleAugmented]
    }
    
    /// The perfect interval quality type that preserves step.
    //static var stepPreserving: [IntervalQuality.EnumKind] { return [perfect] }
    
    static func intervalQuality(fromDirectionDifference difference: Float)
        -> IntervalQuality.EnumKind
    {
        switch difference {
        case -2, -3: return doubleDiminished
        case -1: return diminished
        case +0: return perfect
        case +1: return augmented
        case +2: return doubleAugmented
        default:
            fatalError("Such an interval couldn't possibly exist: \(difference), yet")
        }
    }
    
    static func adjustDifference(difference: Float,
        forLowerPitchSpelling pitchSpelling: PitchSpelling
    ) -> Float
    {
        return pitchSpelling.letterName == .b ? difference - 1 : difference
    }
}
