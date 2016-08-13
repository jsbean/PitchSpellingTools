//
//  NamedInterval.swift
//  PitchSpellingTools
//
//  Created by James Bean on 8/9/16.
//
//

import Foundation
import Pitch

/**
 NamedInterval.
 
 **Example:**
 
 ```
 let perfectUnison = NamedInterval(.perfect, .unison)!
 let augmentedFifth = NamedInterval(.augmented, .fifth)
 let doubleAugmentedSeventh = NamedInterval(.double, .augmented, .seventh)!
 let _ = NamedInterval(.major, .fourth) // nil
 ```
 */
public struct NamedInterval {
    
    /**
     Ordinal of `NamedInterval`.
     
     - TODO: Add documentation!
    */
    public enum Ordinal: Int {

        /// Unison ordinal.
        case unison = 0
        
        /// Second ordinal.
        case second = 1
        
        /// Third ordinal.
        case third = 2
        
        /// Fourth ordinal.
        case fourth = 3
        
        /// Fifth ordinal.
        case fifth = 4
        
        /// Sixth ordinal.
        case sixth = 5
        
        /// Seventh ordinal.
        case seventh = 6

        /**
         Perfect and imperfect class of interval ordinal.
         */
        public enum Family: String {
            
            /**
             Perfect interval family (e.g., `.unison`, `.fourth`, `.fifth`)
             
             > `.diminished`, `.perfect`, and `.augmented` interval qualities allowed.
            */
            case perfect
            
            /**
             Imperfect interval family (e.g., `.second`, `.third`, `.sixth`, `.seventh`)
             
             > `.diminished`, `.minor`, `.major`, and `.augmented` interval qualities allowed.
            */
            case imperfect
        }

        /**
         The inverse of an `Ordinal` 
         (e.g., `.second.inverse == .seventh`, `.third.inverse == .sixth`, etc).
        */
        public var inverse: Ordinal {
            return Ordinal(rawValue: 7 - rawValue)!
        }

        /// `Family` of an `Ordinal`.
        public var family: Family {
            switch self {
            case unison, fourth, fifth: return .perfect
            default: return .imperfect
            }
        }
    }
    
    /**
     `Quality` of a `NamedInterval`.
     
     - TODO: Add documentation!
     */
    public struct Quality: OptionSetType, CustomStringConvertible {
        
        /**
         `Degree` of a `Quality` (e.g., `double augmented second`).
         
         - note: Only applicable for `.augmented` and `.diminished` values.
        */
        public enum Degree: Int {
            case quintuple = 5
            case quadruple = 4
            case triple = 3
            case double = 2
            case single = 1
        }
        
        // MARK: - Cases
        
        /// Diminished `Quality`
        public static let diminished = Quality(rawValue: -2)
        
        /// Minor `Quality`.
        public static let minor = Quality(rawValue: -1)
        
        /// Perfect `Quality`.
        public static let perfect = Quality(rawValue: 0)
        
        /// Major `Quality`.
        public static let major = Quality(rawValue: 1)
        
        /// Augmented `Quality`.
        public static let augmented = Quality(rawValue: 2)
        
        // MARK: - Sets by interval ordinal family
        
        private static let perfectSet: Quality = [diminished, perfect, augmented]
        private static let imperfectSet: Quality = [diminished, minor, major, augmented]
        
        // MARK: - Instance Properties
        
        /**
         Inverse of a `Quality`
         (e.g., `.major.inverse == .minor`, `.perfect.inverse == .perfect`, etc).
        */
        public var inverse: Quality {
            return Quality(rawValue: -1 * rawValue, degree: degree)
        }
        
        /// Raw value of a `Quality`.
        public let rawValue: Int
        
        /// Degree of a `Quality`.
        public let degree: Degree
        
        // MARK: - Initializers
        
        /**
         Create a `NamedInterval.Quality` with a degree.
         */
        public init(rawValue: Int, degree: Degree) {
            self.rawValue = rawValue
            self.degree = degree
        }
        
        /**
         Create a `NamedInterval.Quality`.
         */
        public init(rawValue: Int) {
            self.rawValue = rawValue
            self.degree = .single
        }
        
        // MARK: - Subscripts
        
        /**
         - returns: Quality with the given `degree` if `.diminished` or `.augmented`. 
         Otherwise, `nil`.
         */
        public subscript (degree: Degree) -> Quality? {
            switch (degree, self) {
            case (.single, _), (_, Quality.diminished), (_, Quality.augmented):
                return Quality(rawValue: rawValue, degree: degree)
            default:
                return nil
            }
        }
        
        // MARK: - Instance methods
        
        /**
         - returns: `true` if this `Quality` is valid for a given `Ordinal`. Otherwise, `false`.
        
         > One cannot have a major fifth, etc.
         */
        public func isValid(for ordinal: Ordinal) -> Bool {
            switch ordinal.family {
            case .perfect where Quality.perfectSet.contains(self): return true
            case .imperfect where Quality.imperfectSet.contains(self): return true
            default: return false
            }
        }
        
        // MARK: - CustomStringConvertible
        
        /// Printed description.
        public var description: String {
            var quality: String {
                switch self {
                case Quality.diminished: return "diminished"
                case Quality.minor: return "minor"
                case Quality.perfect: return "perfect"
                case Quality.major: return "major"
                case Quality.augmented: return "augmented"
                default: fatalError()
                }
            }
            return degree == .single ? quality : "\(degree) \(quality)"
        }
    }
    
    /**
     - returns: `Quality` for the given `normalizedIntervalClass` value, and the given 
     `ordinal` value.
     
     - TODO: Find more elegant way to do this. This implementation & api exists only
     - TODO: Factor out duplication in multiply diminished / augmented cases
     - TODO: Handle bad values properly. Currently things can blow up in extreme cases. Test.
     */
    public static func quality(for normalizedIntervalClass: Float, ordinal: Ordinal)
        -> Quality
    {
        let diminished: Float = ordinal.family == .perfect ? -1 : -1.5
        let augmented: Float = ordinal.family == .perfect ? 1 : 1.5

        switch normalizedIntervalClass {
        case _ where normalizedIntervalClass < diminished:
            let degreeValue = Int(abs(normalizedIntervalClass - diminished - 1))
            let degree = Quality.Degree(rawValue: degreeValue)!
            return Quality.diminished[degree]!
        case diminished: return Quality.diminished
        case -0.5: return Quality.minor
        case +0.0: return Quality.perfect
        case +0.5: return Quality.major
        case augmented: return Quality.augmented
        case _ where normalizedIntervalClass > augmented:
            let degreeValue = Int(abs(normalizedIntervalClass - augmented + 1))
            let degree = Quality.Degree(rawValue: degreeValue)!
            return Quality.augmented[degree]!
        default: fatalError() // all cases considered
        }
    }
    
    // MARK: - Type Methods
    
    public static func namedIntervals(for intervalClass: IntervalClass) -> [NamedInterval]? {
        let componentsByIntervalClass: [IntervalClass: [(Quality, Ordinal)]] = [
            00.0: [(.perfect, .unison), (.augmented, .seventh)], // diminished second?
            01.0: [(.minor, .second), (.augmented, .unison)],
            02.0: [(.major, .second), (.diminished, .third)],
            03.0: [(.minor, .third), (.augmented, .second)],
            04.0: [(.major, .third), (.diminished, .fourth)],
            05.0: [(.perfect, .fourth), (.augmented, .third)],
            06.0: [(.diminished, .fifth), (.augmented, .fourth)],
            07.0: [(.perfect, .fifth), (.diminished, .sixth)],
            08.0: [(.minor, .sixth), (.augmented, .fifth)],
            09.0: [(.major, .sixth), (.diminished, .seventh)],
            10.0: [(.minor, .seventh), (.augmented, .sixth)],
            11.0: [(.major, .seventh), (.diminished, .unison)],
        ]
        return componentsByIntervalClass[intervalClass]?.flatMap(NamedInterval.init)
    }
    
    // MARK: - Instance Properties
    
    /**
     Inverse of a `NamedInterval`.
     
     - TODO: Add examples to documentation.
    */
    public var inverse: NamedInterval {
        return NamedInterval(quality.inverse, ordinal.inverse)!
    }
    
    /// Ordinal of a `NamedInterval` (e.g., `.unison`, `.fifth`, `.seventh`, etc.).
    public let ordinal: Ordinal
    
    /// Quality of a `NamedInterval` (e.g., `.perfect`, `.augmented`, `.minor`, etc.).
    public let quality: Quality
    
    // MARK: - Initializers
    
    /**
     Create a `NamedInterval` with a given `quality` and an `ordinal`.
     
     - TODO: Add examples to documentation.
     */
    public init?(_ quality: Quality, _ ordinal: Ordinal) {
        guard quality.isValid(for: ordinal) else { return nil }
        self.quality = quality
        self.ordinal = ordinal
    }
    
    /**
     Create a `NamedInterval` with a `degree`, `quality`, and `ordinal`.
     
     - TODO: Add examples to documentation.
     */
    public init?(_ degree: Quality.Degree, _ quality: Quality, _ ordinal: Ordinal) {
        guard let quality = quality[degree] else { return nil }
        self.init(quality, ordinal)
    }

    /**
     Create a `NamedInterval` with two `SpelledPitch` values.
     */
    public init(_ a: SpelledPitch, _ b: SpelledPitch) {
        let letterNameSteps = steps(a,b)
        let idealInterval = idealIntervalClass(steps: letterNameSteps)
        let intervalClass = normalizedIntervalClass(interval(a,b) - idealInterval)
        let finalIntervalClass = adjustedIntervalClass(intervalClass, given: letterNameSteps)
        self.init(steps: letterNameSteps, intervalClass: finalIntervalClass)!
    }
    
    private init?(steps: Int, intervalClass: Float) {
        guard let ordinal = NamedInterval.Ordinal(rawValue: steps) else { return nil }
        let quality = NamedInterval.quality(for: intervalClass, ordinal: ordinal)
        self.init(quality, ordinal)
    }
}

private func steps(a: SpelledPitch, _ b: SpelledPitch) -> Int {
    return Int.mod(b.spelling.letterName.steps - a.spelling.letterName.steps, 7)
}

private func interval(a: SpelledPitch, _ b: SpelledPitch) -> Float {
    return b.pitch.noteNumber.value - a.pitch.noteNumber.value
}

private func adjustedIntervalClass(intervalClass: Float, given steps: Int) -> Float {
    return steps == 0 ? abs(intervalClass) : intervalClass
}

private func normalizedIntervalClass(normalizedInterval: Float)
    -> Float
{
    return Float.mod(normalizedInterval + 6.0, 12.0) - 6.0
}

private func idealIntervalClass(steps steps: Int) -> Float {
    var idealInterval: Float {
        switch steps {
        case 0: return 0
        case 1: return 1.5
        case 2: return 3.5
        case 3: return 5
        default: fatalError()
        }
    }
    return idealInterval
}

extension NamedInterval: CustomStringConvertible {
    
    // MARK: - CustomStringConvertible
    
    /// Printed description.
    public var description: String {
        return "\(quality) \(ordinal)"
    }
}

extension NamedInterval: Equatable { }

/**
 - returns: `true` if `ordinal` and `quality` values are equivalent. Otherwise, `false`.
 */
public func == (lhs: NamedInterval, rhs: NamedInterval) -> Bool {
    return (
        lhs.ordinal == rhs.ordinal &&
        lhs.quality == rhs.quality &&
        lhs.quality.degree == rhs.quality.degree
    )
}
