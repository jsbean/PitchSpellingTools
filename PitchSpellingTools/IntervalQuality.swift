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

/**
 Quality of Interval between two `SpelledPitch` objects.
 
 >`IntervalQuality.third.major`
 
 >`IntervalQuality.seventh.diminished`
 
 >`IntervalQuality.fourth.augmented`
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
    public class unison: EnumFamily, PerfectIntervalQuatlityType {
        
        
        public static let doubleDiminished: EnumKind = .doubleDiminishedUnison
        
        /// diminished Unison interval.
        public static let diminished: EnumKind = .diminishedUnison
        
        /// perfect Unison interval.
        public static let perfect: EnumKind = .perfectUnison
        
        /// augmented Unison interval.
        public static let augmented: EnumKind = .augmentedUnison
        
        
        public static let doubleAugmented: EnumKind = .doubleAugmentedUnison
        
        public override class func kind(
            forPitchSpellingDyad pitchSpellingDyad: PitchSpellingDyad
        ) -> EnumKind
        {
            let difference = directionDifference(fromPitchSpellingDyad: pitchSpellingDyad)
            return intervalQuality(fromDirectionDifference: difference)
        }
    }
    
    /// Second interval family.
    public class second: EnumFamily, ImperfectIntervalQualityType {
        
        public static let doubleDiminished: EnumKind = .doubleDiminishedSecond
        
        public static let diminished: EnumKind = .diminishedSecond
        
        /// minor Second interval.
        public static let minor: EnumKind = .minorSecond
        
        /// major Second interval.
        public static let major: EnumKind = .majorSecond
        
        /// augmented Second interval.
        public static let augmented: EnumKind = .augmentedSecond
        
        public static let doubleAugmented: EnumKind = .doubleAugmentedSecond
        
        public override class var members: [EnumKind] { return imperfectMembers }
        
        public override class func kind(
            forPitchSpellingDyad pitchSpellingDyad: PitchSpellingDyad
        ) -> EnumKind
        {
            let difference = directionDifference(fromPitchSpellingDyad: pitchSpellingDyad)
            return intervalQuality(fromDirectionDifference: difference)
        }
    }
    
    /// Third interval family.
    public class third: EnumFamily, ImperfectIntervalQualityType {
        
        public static let doubleDiminished: EnumKind = .doubleDiminishedThird
        
        /// diminished Third interval.
        public static let diminished: EnumKind = .diminishedThird
        
        /// minor Third interval.
        public static let minor: EnumKind = .minorThird
        
        /// major Third interval.
        public static let major: EnumKind = .majorThird
        
        /// augmented Third interval.
        public static let augmented: EnumKind = .augmentedThird
        
        public static let doubleAugmented: EnumKind = .doubleAugmentedThird
        
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
    public class fourth: EnumFamily, PerfectIntervalQuatlityType {
        
        public static let doubleDiminished: EnumKind = .doubleDiminishedFourth
        
        /// diminished Fourth interval.
        public static let diminished: EnumKind = .diminishedFourth
        
        /// perfect Fourth interval.
        public static let perfect: EnumKind = .perfectFourth
        
        /// augmented Fouth interval.
        public static let augmented: EnumKind = .augmentedFourth
        
        public static let doubleAugmented: EnumKind = .doubleAugmentedFourth
        
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
            return pitchSpelling.letterName == .f ? difference + 1 : difference
        }
    }
    
    /// Fifth interval family.
    public class fifth: EnumFamily, PerfectIntervalQuatlityType {
        
        public static let doubleDiminished: EnumKind = .doubleDiminishedFifth
        
        /// diminished Fifth interval.
        public static let diminished: EnumKind = .diminishedFifth
        
        /// perfect Fifth interval.
        public static let perfect: EnumKind = .perfectFifth
        
        /// augmented Fifth interval.
        public static let augmented: EnumKind = .augmentedFifth
        
        public static let doubleAugmented: EnumKind = .doubleDiminishedFifth
        
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
    public class sixth: EnumFamily, ImperfectIntervalQualityType {
        
        public static let doubleDiminished: EnumKind = .doubleDiminishedSixth
        
        /// diminished Sixth interval.
        public static let diminished: EnumKind = .diminishedSixth
        
        /// minor Sixth interval.
        public static let minor: EnumKind = .minorSixth
        
        /// major Sixth interval.
        public static let major: EnumKind = .majorSixth
        
        /// augmented Sixth interval.
        public static let augmented: EnumKind = .augmentedSixth
        
        public static let doubleAugmented: EnumKind = .doubleAugmentedSixth
        
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
    public class seventh: EnumFamily, ImperfectIntervalQualityType {
        
        public static let doubleDiminished: EnumKind = .doubleDiminishedSeventh
        
        /// diminished Seventh interval.
        public static let diminished: EnumKind = .diminishedSeventh
        
        /// minor Seventh interval.
        public static let minor: EnumKind = .minorSeventh
        
        /// major Seventh interval.
        public static let major: EnumKind = .majorSeventh
        
        /// augmented Seventh interal.
        public static let augmented: EnumKind = .augmentedSeventh
        
        public static var doubleAugmented: EnumKind = .doubleAugmentedSeventh
        
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
            unison.self,
            second.self,
            third.self,
            fourth.self,
            fifth.self,
            sixth.self,
            seventh.self
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
        case 0: return unison.self
        case 1: return second.self
        case 2: return third.self
        case 3: return fourth.self
        case 4: return fifth.self
        case 5: return sixth.self
        case 6: return seventh.self
        default: fatalError()
        }
    }
    
    private func intervalQualityKinds(withIntervalClass intervalClass: IntervalClass)
        -> [IntervalQualityKind]
    {
        return intervalQualityKinds(withIntervalClass: intervalClass) ?? []
    }
}

