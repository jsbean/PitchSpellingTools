//
//  IntervalQuality.swift
//  Pitch
//
//  Created by James Bean on 4/30/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import EnumTools
import Pitch

/**
 Quality of Interval between two `SpelledPitch` objects.
 
 >`IntervalQuality.Third.Major`
 
 >`IntervalQuality.Seventh.Diminished`
 
 >`IntervalQuality.Fourth.Augmented`
 */
public class IntervalQuality: EnumTree {

    // MARK: - Associated Types

    public typealias EnumKind = IntervalQualityKind
    public typealias EnumFamily = IntervalQuality
    
    private static let intervalQualityKindByIntervalClass:
        [IntervalClass: [IntervalQualityKind]] =
    [
        00: [.PerfectUnison, .AugmentedSeventh],
        01: [.MinorSecond, .AugmentedUnison],
        02: [.MajorSecond, .DiminishedThird],
        03: [.MinorThird, .AugmentedSecond],
        04: [.MajorThird, .DiminishedFourth],
        05: [.PerfectFourth, .AugmentedThird],
        06: [.DiminishedFifth, .AugmentedFourth],
        07: [.PerfectFifth, .DiminishedFifth],
        08: [.MinorSixth, .AugmentedFifth],
        09: [.MajorSixth, .DiminishedSeventh],
        10: [.MinorSeventh, .AugmentedSixth],
        11: [.MajorSeventh, .DiminishedUnison],
    ]
    
    // MARK: - Interval Families
    
    /// Unison interval family.
    public class Unison: EnumFamily {
        
        /// Diminished Unison interval.
        public static let Diminished: EnumKind = .DiminishedUnison
        
        /// Perfect Unison interval.
        public static let Perfect: EnumKind = .PerfectUnison
        
        /// Augmented Unison interval.
        public static let Augmented: EnumKind = .AugmentedUnison
        
        public override class var members: [EnumKind] { return [Perfect, Augmented] }
        
        public override class func kind(
            coarseAdjustmentLower: PitchSpelling.CoarseAdjustment,
            _ coarseAdjustmentHigher: PitchSpelling.CoarseAdjustment
        ) -> EnumKind
        {
            // refactor
            if coarseAdjustmentLower.direction == coarseAdjustmentHigher.direction {
                return Perfect
            } else if coarseAdjustmentLower.direction.rawValue > coarseAdjustmentHigher.direction.rawValue {
                return Diminished
            } else {
                return Augmented
            }
        }
    }
    
    /// Second interval family.
    public class Second: EnumFamily {
        
        /// Minor Second interval.
        public static let Minor: EnumKind = .MinorSecond
        
        /// Major Second interval.
        public static let Major: EnumKind = .MajorSecond
        
        /// Augmented Second interval.
        public static let Augmented: EnumKind = .AugmentedSecond
        
        public override class var members: [EnumKind] { return [Minor, Major, Augmented] }
        
        public override class func kind(
            coarseAdjustmentLower: PitchSpelling.CoarseAdjustment,
            _ coarseAdjustmentHigher: PitchSpelling.CoarseAdjustment
        ) -> EnumKind
        {
            // refactor
            if coarseAdjustmentLower.direction == coarseAdjustmentHigher.direction {
                return Major
            } else if coarseAdjustmentLower.direction.rawValue > coarseAdjustmentHigher.direction.rawValue {
                return Minor
            } else {
                return Augmented
            }
        }
    }
    
    /// Third interval family.
    public class Third: EnumFamily {
        
        /// Diminished Third interval.
        public static let Diminished: EnumKind = .DiminishedThird
        
        /// Minor Third interval.
        public static let Minor: EnumKind = .MinorThird
        
        /// Major Third interval.
        public static let Major: EnumKind = .MajorThird
        
        /// Augmented Third interval.
        public static let Augmented: EnumKind = .AugmentedThird
        
        public override class var members: [EnumKind] {
            return [Diminished, Minor, Major, Augmented]
        }
        
        public override class func kind(
            coarseAdjustmentLower: PitchSpelling.CoarseAdjustment,
            _ coarseAdjustmentHigher: PitchSpelling.CoarseAdjustment
        ) -> EnumKind
        {
            let diff = coarseAdjustmentHigher.direction.rawValue - coarseAdjustmentLower.direction.rawValue
            switch diff {
            case -2: return Diminished
            case -1: return Minor
            case 0: return Major
            case 2: return Augmented
            default: fatalError() // impossible?
            }
        }
    }
    
    /// Fourth interval family.
    public class Fourth: EnumFamily {
        
        /// Diminished Fourth interval.
        public static let Diminished: EnumKind = .DiminishedFourth
        
        /// Perfect Fourth interval.
        public static let Perfect: EnumKind = .PerfectFourth
        
        /// Augmented Fouth interval.
        public static let Augmented: EnumKind = .AugmentedFourth
        
        public override class var members: [EnumKind] {
            return [Diminished, Perfect, Augmented]
        }

        public override class func kind(
            coarseAdjustmentLower: PitchSpelling.CoarseAdjustment,
            _ coarseAdjustmentHigher: PitchSpelling.CoarseAdjustment
        ) -> EnumKind
        {
            // refactor
            if coarseAdjustmentLower.direction == coarseAdjustmentHigher.direction {
                return Perfect
            } else if coarseAdjustmentLower.direction.rawValue > coarseAdjustmentHigher.direction.rawValue {
                return Diminished
            } else {
                return Augmented
            }
        }
    }
    
    /// Fifth interval family.
    public class Fifth: EnumFamily {
        
        /// Diminished Fifth interval.
        public static let Diminished: EnumKind = .DiminishedFifth
        
        /// Perfect Fifth interval.
        public static let Perfect: EnumKind = .PerfectFifth
        
        /// Augmented Fifth interval.
        public static let Augmented: EnumKind = .AugmentedFifth
        
        public override class var members: [EnumKind] {
            return [Diminished, Perfect, Augmented]
        }
        
        public override class func kind(
            coarseAdjustmentLower: PitchSpelling.CoarseAdjustment,
            _ coarseAdjustmentHigher: PitchSpelling.CoarseAdjustment
        ) -> EnumKind
        {
            // refactor
            if coarseAdjustmentLower.direction == coarseAdjustmentHigher.direction {
                return Perfect
            } else if coarseAdjustmentLower.direction.rawValue > coarseAdjustmentHigher.direction.rawValue {
                return Diminished
            } else {
                return Augmented
            }
        }
    }
    
    /// Sixth interval family.
    public class Sixth: EnumFamily {
        
        /// Diminished Sixth interval.
        public static let Diminished: EnumKind = .DiminishedSixth
        
        /// Minor Sixth interval.
        public static let Minor: EnumKind = .MinorSixth
        
        /// Major Sixth interval.
        public static let Major: EnumKind = .MajorSixth
        
        /// Augmented Sixth interval.
        public static let Augmented: EnumKind = .AugmentedSixth
        
        public override class var members: [EnumKind] {
            return [Diminished, Minor, Major, Augmented]
        }
        
        public override class func kind(
            coarseAdjustmentLower: PitchSpelling.CoarseAdjustment,
            _ coarseAdjustmentHigher: PitchSpelling.CoarseAdjustment
        ) -> EnumKind
        {
            let diff = coarseAdjustmentHigher.direction.rawValue - coarseAdjustmentLower.direction.rawValue
            switch diff {
            case -2: return Diminished
            case -1: return Minor
            case 0: return Major
            case 1: return Augmented
            default: fatalError() // impossible?
            }
        }
    }
    
    /// Seventh interval family.
    public class Seventh: EnumFamily {
        
        /// Diminished Seventh interval.
        public static let Diminished: EnumKind = .DiminishedSeventh
        
        /// Minor Seventh interval.
        public static let Minor: EnumKind = .MinorSeventh
        
        /// Major Seventh interval.
        public static let Major: EnumKind = .MajorSeventh
        
        /// Augmented Seventh interal.
        public static let Augmented: EnumKind = .AugmentedSeventh
        
        public override class var members: [EnumKind] {
            return [Diminished, Minor, Major, Augmented]
        }
        
        public override class func kind(
            coarseAdjustmentLower: PitchSpelling.CoarseAdjustment,
            _ coarseAdjustmentHigher: PitchSpelling.CoarseAdjustment
        ) -> EnumKind
        {
            let diff = coarseAdjustmentHigher.direction.rawValue - coarseAdjustmentLower.direction.rawValue
            switch diff {
            case -2: return Diminished
            case -1: return Minor
            case 0: return Major
            case 1: return Augmented
            default: fatalError() // impossible?
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
    
    public class func kind(
        coarseAdjustmentLower: PitchSpelling.CoarseAdjustment,
        _ coarseAdjustmentHigher: PitchSpelling.CoarseAdjustment
    ) -> EnumKind
    {
        return .AugmentedFifth
    }
    
    internal func intervalQualityKinds(withIntervalClass intervalClass: IntervalClass)
        -> [IntervalQualityKind]
    {
        return intervalQualityKinds(withIntervalClass: intervalClass) ?? []
    }
    
    public static func intervalFamily(withAmountOfSteps steps: Int) -> EnumFamily.Type {
        // refine where to do abs(steps)
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
}

/**
 All interval qualities with a half-step resolution. 
 Flat resource which is wrapped hierarchically by `IntervalQuality`.
 */
public enum IntervalQualityKind: String {
    
    case DiminishedUnison = "d1"
    case PerfectUnison = "P1"
    case AugmentedUnison = "A1"
    
    case MinorSecond = "m2"
    case MajorSecond = "M2"
    case AugmentedSecond = "A2"

    case DiminishedThird = "d3"
    case MinorThird	= "m3"
    case MajorThird	= "M3"
    case AugmentedThird = "A3"
    
    case DiminishedFourth = "d4"
    case PerfectFourth = "P4"
    case AugmentedFourth = "A4"
    
    case DiminishedFifth = "d5"
    case PerfectFifth = "P5"
    case AugmentedFifth = "A5"
    
    case DiminishedSixth = "d6"
    case MinorSixth = "m6"
    case MajorSixth = "M6"
    case AugmentedSixth = "A6"
    
    case DiminishedSeventh = "d7"
    case MinorSeventh = "m7"
    case MajorSeventh = "M7"
    case AugmentedSeventh = "A7"
    
    internal static var stepPreserving: [IntervalQualityKind] = [
        .PerfectUnison,
        .MinorSecond,
        .MajorSecond,
        .MinorThird,
        .MajorThird,
        .PerfectFourth,
        .PerfectFifth,
        .MinorSixth,
        .MajorSixth,
        .MinorSeventh,
        .MajorSeventh
    ]
    
    public var isStepPreserving: Bool {
        return IntervalQualityKind.stepPreserving.contains(self)
    }
}