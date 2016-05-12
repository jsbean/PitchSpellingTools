//
//  PerfectIntervalQualityType.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/11/16.
//
//

import ArithmeticTools

internal protocol PerfectIntervalQuatlityType: IntervalQualityType {
    static var perfect: IntervalQuality.EnumKind { get }
    static var perfectMembers: [IntervalQuality.EnumKind] { get }
}

extension PerfectIntervalQuatlityType {
    
    static var perfectMembers: [IntervalQuality.EnumKind] {
        return [perfect, diminished, augmented]
    }
    
    static var stepPreserving: [IntervalQuality.EnumKind] { return [perfect] }
    
    static func intervalQuality(fromDirectionDifference difference: Float)
        -> IntervalQuality.EnumKind
    {
        switch compare(difference, 0) {
        case .lessThan: return diminished
        case .equal: return perfect
        case .greaterThan: return augmented
        }
    }
    
    static func adjustDifference(difference: Float,
                                 forLowerPitchSpelling pitchSpelling: PitchSpelling
        ) -> Float
    {
        return pitchSpelling.letterName == .b ? difference - 1 : difference
    }
}
