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

internal protocol IntervalQualityType: EnumTree {
    
    static var diminished: IntervalQuality.EnumKind { get }
    
    static var augmented: IntervalQuality.EnumKind { get }
    
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

internal protocol PerfectIntervalQuatlityType: IntervalQualityType {
    static var perfect: IntervalQuality.EnumKind { get }
    static var perfectMembers: [IntervalQuality.EnumKind] { get }
}

extension PerfectIntervalQuatlityType {
    
    static var perfectMembers: [IntervalQuality.EnumKind] {
        return [perfect, diminished, augmented]
    }
    
    static func intervalQuality(fromDirectionDifference difference: Float)
        -> IntervalQuality.EnumKind
    {
        switch difference {
        case -1, -2: return diminished
        case -0: return perfect
        case +1, +2: return augmented
        default: fatalError("Such an interval couldn't possibly exist")
        }
    }
}

internal protocol ImperfectIntervalQualityType: IntervalQualityType {
    static var major: IntervalQuality.EnumKind { get }
    static var minor: IntervalQuality.EnumKind { get }
    static var imperfectMembers: [IntervalQuality.EnumKind] { get }
}

extension ImperfectIntervalQualityType {
    
    static var imperfectMembers: [IntervalQuality.EnumKind] {
        return [major, minor, diminished, augmented]
    }
    
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
        
        static func adjustDifference(difference: Float,
            forLowerPitchSpelling pitchSpelling: PitchSpelling
        ) -> Float
        {
            return pitchSpelling.letterName == .b ? difference - 1 : difference
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
        
        static func adjustDifference(difference: Float,
            forLowerPitchSpelling pitchSpelling: PitchSpelling
        ) -> Float
        {
            return pitchSpelling.letterName == .b ? difference - 1 : difference
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
        
        // DEFAULT Impefect implementation
        public override class func kind(forPitchSpellingDyad pitchSpellingDyad: PitchSpellingDyad)
            -> EnumKind
        {
            // exception if lower is B or E
            let lowerDirection = pitchSpellingDyad.lower.coarse.direction.rawValue
            let higherDirection = pitchSpellingDyad.higher.coarse.direction.rawValue
            var difference: Float {
                var result = (higherDirection - lowerDirection)
                if [.b, .e].contains(pitchSpellingDyad.lower.letterName) { result -= 1 }
                return result
            }
            switch difference {
            case -2: return diminished
            case -1: return minor
            case +0: return major
            case +1: return augmented
            default: fatalError("Such an interval couldn't possibly exist")
            }
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

/**
 All interval qualities with a half-step resolution. 
 Flat resource which is wrapped hierarchically by `IntervalQuality`.
 */
public enum IntervalQualityKind: String {
    
    case diminishedUnison = "d1"
    case perfectUnison = "P1"
    case augmentedUnison = "A1"
 
    case diminishedSecond = "d2"
    case minorSecond = "m2"
    case majorSecond = "M2"
    case augmentedSecond = "A2"

    case diminishedThird = "d3"
    case minorThird	= "m3"
    case majorThird	= "M3"
    case augmentedThird = "A3"
    
    case diminishedFourth = "d4"
    case perfectFourth = "P4"
    case augmentedFourth = "A4"
    
    case diminishedFifth = "d5"
    case perfectFifth = "P5"
    case augmentedFifth = "A5"
    
    case diminishedSixth = "d6"
    case minorSixth = "m6"
    case majorSixth = "M6"
    case augmentedSixth = "A6"
    
    case diminishedSeventh = "d7"
    case minorSeventh = "m7"
    case majorSeventh = "M7"
    case augmentedSeventh = "A7"
    
    internal static var stepPreserving: [IntervalQualityKind] = [
        .perfectUnison,
        .minorSecond,
        .majorSecond,
        .minorThird,
        .majorThird,
        .perfectFourth,
        .perfectFifth,
        .minorSixth,
        .majorSixth,
        .minorSeventh,
        .majorSeventh
    ]
    
    public var isStepPreserving: Bool {
        return IntervalQualityKind.stepPreserving.contains(self)
    }
}