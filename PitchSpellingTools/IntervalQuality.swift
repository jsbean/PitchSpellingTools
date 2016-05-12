//
//  IntervalQuality.swift
//  Pitch
//
//  Created by James Bean on 4/30/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import ArithmeticTools
import EnumTools
import Pitch

// TODO: implement stepPreserving intervals for each type


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

internal protocol ImperfectIntervalQualityType: IntervalQualityType {
    static var major: IntervalQuality.EnumKind { get }
    static var minor: IntervalQuality.EnumKind { get }
    static var imperfectMembers: [IntervalQuality.EnumKind] { get }
}

extension ImperfectIntervalQualityType {
    
    static var imperfectMembers: [IntervalQuality.EnumKind] {
        return [diminished, minor, major, augmented]
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
        case -2: return diminished
        case -1: return minor
        case +0: return major
        case +1: return augmented
        default: fatalError("Such an interval couldn't possibly exist")
        }
    }
}

/**
 Quality of Interval between two `SpelledPitch` objects.
 
 >`IntervalQuality.Third.major`
 
 >`IntervalQuality.Seventh.diminished`
 
 >`IntervalQuality.Fourth.augmented`
 */
public class IntervalQuality: EnumTree {

    // MARK: - Associated Types

    public typealias EnumKind = IntervalQualityKind
    public typealias EnumFamily = IntervalQuality
    
    private static let intervalQualityKindByIntervalClass:
        [IntervalClass: [IntervalQualityKind]] =
    [
        00.0: [.perfectUnison, .augmentedSeventh],
        01.0: [.minorSecond, .augmentedUnison],
        02.0: [.majorSecond, .diminishedThird],
        03.0: [.minorThird, .augmentedSecond],
        04.0: [.majorThird, .diminishedFourth],
        05.0: [.perfectFourth, .augmentedThird],
        06.0: [.diminishedFifth, .augmentedFourth],
        07.0: [.perfectFifth, .diminishedFifth],
        08.0: [.minorSixth, .augmentedFifth],
        09.0: [.majorSixth, .diminishedSeventh],
        10.0: [.minorSeventh, .augmentedSixth],
        11.0: [.majorSeventh, .diminishedUnison],
    ]
    
    // MARK: - Interval Families
    
    /// Unison interval family.
    public class Unison: EnumFamily, PerfectIntervalQuatlityType {
        
        /// diminished Unison interval.
        public static let diminished: EnumKind = .diminishedUnison
        
        /// perfect Unison interval.
        public static let perfect: EnumKind = .perfectUnison
        
        /// augmented Unison interval.
        public static let augmented: EnumKind = .augmentedUnison
        
        public override class var members: [EnumKind] { return perfectMembers }
        
        // DEFAULT Perfect implementation
        public override class func kind(
            forPitchSpellingDyad pitchSpellingDyad: PitchSpellingDyad
        ) -> EnumKind
        {
            let difference = directionDifference(fromPitchSpellingDyad: pitchSpellingDyad)
            return intervalQuality(fromDirectionDifference: difference)
        }
    }
    
    /// Second interval family.
    public class Second: EnumFamily, ImperfectIntervalQualityType {
        
        public static let diminished: EnumKind = .diminishedSecond
        
        /// minor Second interval.
        public static let minor: EnumKind = .minorSecond
        
        /// major Second interval.
        public static let major: EnumKind = .majorSecond
        
        /// augmented Second interval.
        public static let augmented: EnumKind = .augmentedSecond
        
        public override class var members: [EnumKind] { return imperfectMembers }
        
        public override class func kind(forPitchSpellingDyad pitchSpellingDyad: PitchSpellingDyad)
            -> EnumKind
        {
            let difference = directionDifference(fromPitchSpellingDyad: pitchSpellingDyad)
            return intervalQuality(fromDirectionDifference: difference)
        }
    }
    
    /// Third interval family.
    public class Third: EnumFamily, ImperfectIntervalQualityType {
        
        /// diminished Third interval.
        public static let diminished: EnumKind = .diminishedThird
        
        /// minor Third interval.
        public static let minor: EnumKind = .minorThird
        
        /// major Third interval.
        public static let major: EnumKind = .majorThird
        
        /// augmented Third interval.
        public static let augmented: EnumKind = .augmentedThird
        
        public override class var members: [EnumKind] { return imperfectMembers }
        
        public override class func kind(
            forPitchSpellingDyad pitchSpellingDyad: PitchSpellingDyad
        ) -> EnumKind
        {
            let difference = directionDifference(fromPitchSpellingDyad: pitchSpellingDyad)
            return intervalQuality(fromDirectionDifference: difference)
        }
    }
    
    /// Fourth interval family.
    public class Fourth: EnumFamily, PerfectIntervalQuatlityType {
        
        /// diminished Fourth interval.
        public static let diminished: EnumKind = .diminishedFourth
        
        /// perfect Fourth interval.
        public static let perfect: EnumKind = .perfectFourth
        
        /// augmented Fouth interval.
        public static let augmented: EnumKind = .augmentedFourth
        
        public override class var members: [EnumKind] { return perfectMembers }
        
        public override class func kind(forPitchSpellingDyad pitchSpellingDyad: PitchSpellingDyad)
            -> EnumKind
        {
            let difference = directionDifference(fromPitchSpellingDyad: pitchSpellingDyad)
            return intervalQuality(fromDirectionDifference: difference)
        }
        
        static func adjustDifference(difference: Float,
            forLowerPitchSpelling pitchSpelling: PitchSpelling
        ) -> Float
        {
            return pitchSpelling.letterName == .f ? difference + 1 : difference
        }
    }
    
    /// Fifth interval family.
    public class Fifth: EnumFamily, PerfectIntervalQuatlityType {
        
        /// diminished Fifth interval.
        public static let diminished: EnumKind = .diminishedFifth
        
        /// perfect Fifth interval.
        public static let perfect: EnumKind = .perfectFifth
        
        /// augmented Fifth interval.
        public static let augmented: EnumKind = .augmentedFifth
        
        public override class var members: [EnumKind] { return perfectMembers }
    
        public override class func kind(
            forPitchSpellingDyad pitchSpellingDyad: PitchSpellingDyad
        ) -> EnumKind
        {
            let difference = directionDifference(fromPitchSpellingDyad: pitchSpellingDyad)
            return intervalQuality(fromDirectionDifference: difference)
        }
    }
    
    /// Sixth interval family.
    public class Sixth: EnumFamily, ImperfectIntervalQualityType {
        
        /// diminished Sixth interval.
        public static let diminished: EnumKind = .diminishedSixth
        
        /// minor Sixth interval.
        public static let minor: EnumKind = .minorSixth
        
        /// major Sixth interval.
        public static let major: EnumKind = .majorSixth
        
        /// augmented Sixth interval.
        public static let augmented: EnumKind = .augmentedSixth
        
        public override class var members: [EnumKind] { return imperfectMembers }
        
        public override class func kind(
            forPitchSpellingDyad pitchSpellingDyad: PitchSpellingDyad
            ) -> EnumKind
        {
            let difference = directionDifference(fromPitchSpellingDyad: pitchSpellingDyad)
            return intervalQuality(fromDirectionDifference: difference)
        }
    }
    
    /// Seventh interval family.
    public class Seventh: EnumFamily, ImperfectIntervalQualityType {
        
        /// diminished Seventh interval.
        public static let diminished: EnumKind = .diminishedSeventh
        
        /// minor Seventh interval.
        public static let minor: EnumKind = .minorSeventh
        
        /// major Seventh interval.
        public static let major: EnumKind = .majorSeventh
        
        /// augmented Seventh interal.
        public static let augmented: EnumKind = .augmentedSeventh
        
        public override class var members: [EnumKind] { return imperfectMembers }
        
        public override class func kind(
            forPitchSpellingDyad pitchSpellingDyad: PitchSpellingDyad
        ) -> EnumKind
        {
            let difference = directionDifference(fromPitchSpellingDyad: pitchSpellingDyad)
            return intervalQuality(fromDirectionDifference: difference)
        }
    }
    
    public class var members: [EnumKind] { return [] }
    
    public class var subFamilies: [EnumFamily.Type] {
        return [
            Unison.self,
            Second.self,
            Third.self,
            Fourth.self,
            Fifth.self,
            Sixth.self,
            Seventh.self
        ]
    }
    
    public class func kind(forPitchSpellingDyad pitchSpellingDyad: PitchSpellingDyad)
        -> EnumKind
    {
        let family = intervalFamily(withAmountOfSteps: pitchSpellingDyad.steps)
        return family.kind(forPitchSpellingDyad: pitchSpellingDyad)
    }
    
    private static func intervalFamily(withAmountOfSteps steps: Int) -> EnumFamily.Type {
        switch abs(steps) % 7 {
        case 0: return Unison.self
        case 1: return Second.self
        case 2: return Third.self
        case 3: return Fourth.self
        case 4: return Fifth.self
        case 5: return Sixth.self
        case 6: return Seventh.self
        default: fatalError()
        }
    }
    
    private func intervalQualityKinds(withIntervalClass intervalClass: IntervalClass)
        -> [IntervalQualityKind]
    {
        return intervalQualityKinds(withIntervalClass: intervalClass) ?? []
    }
}

