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
    public class unison: EnumFamily, PerfectIntervalQualityType {
        
        /// Double Diminished Unison interval.
        public static let doubleDiminished: EnumKind = .doubleDiminishedUnison
        
        /// Diminished Unison interval.
        public static let diminished: EnumKind = .diminishedUnison
        
        /// Perfect Unison interval.
        public static let perfect: EnumKind = .perfectUnison
        
        /// Augmented Unison interval.
        public static let augmented: EnumKind = .augmentedUnison
        
        /// Double Augmented Unison interval.
        public static let doubleAugmented: EnumKind = .doubleAugmentedUnison
        
        public static var stepPreserving: [EnumKind] { return [perfect] }
        
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
        
        /// Double Diminished Second interval.
        public static let doubleDiminished: EnumKind = .doubleDiminishedSecond
        
        /// Diminished Second interval.
        public static let diminished: EnumKind = .diminishedSecond
        
        /// Minor Second interval.
        public static let minor: EnumKind = .minorSecond
        
        /// Major Second interval.
        public static let major: EnumKind = .majorSecond
        
        /// Augmented Second interval.
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
        
        /// Double Diminished Third interval.
        public static let doubleDiminished: EnumKind = .doubleDiminishedThird
        
        /// Diminished Third interval.
        public static let diminished: EnumKind = .diminishedThird
        
        /// Minor Third interval.
        public static let minor: EnumKind = .minorThird
        
        /// Major Third interval.
        public static let major: EnumKind = .majorThird
        
        /// Augmented Third interval.
        public static let augmented: EnumKind = .augmentedThird
        
        /// Double Augmented Third interval.
        public static let doubleAugmented: EnumKind = .doubleAugmentedThird
        
        /// Imperfect interval quality type members
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
    public class fourth: EnumFamily, PerfectIntervalQualityType {
        
        /// Double Diminished Fourth interval.
        public static let doubleDiminished: EnumKind = .doubleDiminishedFourth
        
        /// Diminished Fourth interval.
        public static let diminished: EnumKind = .diminishedFourth
        
        /// Perfect Fourth interval.
        public static let perfect: EnumKind = .perfectFourth
        
        /// Augmented Fouth interval.
        public static let augmented: EnumKind = .augmentedFourth
        
        /// Double Augmented Fourt interval.
        public static let doubleAugmented: EnumKind = .doubleAugmentedFourth
        
        public static var stepPreserving: [EnumKind] {
            return [perfect, diminished, augmented]
        }
        
        /// Perfect interval quality type members.
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
    public class fifth: EnumFamily, PerfectIntervalQualityType {
        
        /// Double Diminished Fifth interval.
        public static let doubleDiminished: EnumKind = .doubleDiminishedFifth
        
        /// Diminished Fifth interval.
        public static let diminished: EnumKind = .diminishedFifth
        
        /// Perfect Fifth interval.
        public static let perfect: EnumKind = .perfectFifth
        
        /// Augmented Fifth interval.
        public static let augmented: EnumKind = .augmentedFifth
        
        /// Double Augmented Fifth interval.
        public static let doubleAugmented: EnumKind = .doubleAugmentedFifth
        
        public static var stepPreserving: [EnumKind] {
            return [perfect, diminished, augmented]
        }
        
        /// Perfect interval quality type members.
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
        
        /// Double Diminished Sixth interval.
        public static let doubleDiminished: EnumKind = .doubleDiminishedSixth
        
        /// Diminished Sixth interval.
        public static let diminished: EnumKind = .diminishedSixth
        
        /// Minor Sixth interval.
        public static let minor: EnumKind = .minorSixth
        
        /// Major Sixth interval.
        public static let major: EnumKind = .majorSixth
        
        /// Augmented Sixth interval.
        public static let augmented: EnumKind = .augmentedSixth
        
        /// Double Augmented Sixth interval.
        public static let doubleAugmented: EnumKind = .doubleAugmentedSixth
        
        /// Imperfect interval quality type members.
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
        
        /// Double Diminished Seventh interval.
        public static let doubleDiminished: EnumKind = .doubleDiminishedSeventh
        
        /// Diminished Seventh interval.
        public static let diminished: EnumKind = .diminishedSeventh
        
        /// Minor Seventh interval.
        public static let minor: EnumKind = .minorSeventh
        
        /// Major Seventh interval.
        public static let major: EnumKind = .majorSeventh
        
        /// Augmented Seventh interal.
        public static let augmented: EnumKind = .augmentedSeventh
        
        /// Double Augmented Seventh interval.
        public static var doubleAugmented: EnumKind = .doubleAugmentedSeventh
        
        /// Imperfect interval quality type members.
        public override class var members: [EnumKind] { return imperfectMembers }
        
        public override class func kind(
            forPitchSpellingDyad pitchSpellingDyad: PitchSpellingDyad
        ) -> EnumKind
        {
            let difference = directionDifference(fromPitchSpellingDyad: pitchSpellingDyad)
            return intervalQuality(fromDirectionDifference: difference)
        }
    }
    
    /// - warning: Default implementation: `[]`. Must override.
    public class var members: [EnumKind] { return [] }
    
    /**
     Interval quantity families:
     
        - `unison`
        - `second`
        - `third`
        - `fourth`
        - `fifth`
        - `sixth`
        - `seventh`
     */
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

