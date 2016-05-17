//
//  ImperfectIntervalQualityType.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/11/16.
//
//

import EnumTools

internal protocol ImperfectIntervalQualityType: IntervalQualityType {
    static var major: IntervalQuality.EnumKind { get }
    static var minor: IntervalQuality.EnumKind { get }
}

extension ImperfectIntervalQualityType {
    
    static var imperfectMembers: [IntervalQuality.EnumKind] {
        return [doubleDiminished, diminished, minor, major, augmented, doubleAugmented]
    }
    
    static var stepPreserving: [IntervalQuality.EnumKind] { return [minor, major] }
    
    static func adjustDifference(difference: Float,
        forLowerPitchSpelling pitchSpelling: PitchSpelling
    ) -> Float
    {
        return [.b, .e].contains(pitchSpelling.letterName) ? difference - 1 : difference
    }
    
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
