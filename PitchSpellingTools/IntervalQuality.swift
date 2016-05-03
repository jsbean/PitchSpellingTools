//
//  IntervalQuality.swift
//  Pitch
//
//  Created by James Bean on 4/30/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import EnumTools
import Pitch

// there are three types of interval families:
// - P, D, A (4, 5, 8)
// -
// 

/// Quality of Interval between two `SpelledPitch` objects.
public class IntervalQuality: EnumTree {
    
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
    
    public class Unison: EnumFamily {
        public static let Diminished: EnumKind = .DiminishedUnison
        public static let Perfect: EnumKind = .PerfectUnison
        public static let Augmented: EnumKind = .AugmentedUnison
        
        public override class var members: [EnumKind] { return [Perfect, Augmented] }
        
        public override class func kind(
            coarseAdjustmentLower: PitchSpelling.CoarseAdjustment,
            _ coarseAdjustmentHigher: PitchSpelling.CoarseAdjustment
        ) -> EnumKind
        {
            print("unison method")
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
    
    public class Second: EnumFamily {
        public static let Minor: EnumKind = .MinorSecond
        public static let Major: EnumKind = .MajorSecond
        public static let Augmented: EnumKind = .AugmentedSecond
        
        public override class var members: [EnumKind] { return [Minor, Major, Augmented] }
        
        public override class func kind(
            coarseAdjustmentLower: PitchSpelling.CoarseAdjustment,
            _ coarseAdjustmentHigher: PitchSpelling.CoarseAdjustment
        ) -> EnumKind
        {
            
            print("second method")
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
    
    public class Third: EnumFamily {
        public static let Diminished: EnumKind = .DiminishedThird
        public static let Minor: EnumKind = .MinorThird
        public static let Major: EnumKind = .MajorThird
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
            case 1: return Augmented
            default: fatalError() // impossible?
            }
        }
    }
    
    public class Fourth: EnumFamily {
        public static let Diminished: EnumKind = .DiminishedFourth
        public static let Perfect: EnumKind = .PerfectFourth
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
    
    public class Fifth: EnumFamily {
        public static let Diminished: EnumKind = .DiminishedFifth
        public static let Perfect: EnumKind = .PerfectFifth
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
    
    public class Sixth: EnumFamily {
        public static let Diminished: EnumKind = .DiminishedSixth
        public static let Minor: EnumKind = .MinorSixth
        public static let Major: EnumKind = .MajorSixth
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
    
    public class Seventh: EnumFamily {
        public static let Diminished: EnumKind = .DiminishedSeventh
        public static let Minor: EnumKind = .MinorSeventh
        public static let Major: EnumKind = .MajorSeventh
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
        print("steps: \(steps); mod 7: \(steps % 7)")
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
}