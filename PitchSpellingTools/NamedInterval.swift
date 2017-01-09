//
//  NamedInterval.swift
//  PitchSpellingTools
//
//  Created by James Bean on 8/9/16.
//
//

/// Interface for types describing intervals between `SpelledPitch` values.
public protocol NamedInterval: Invertible, Equatable {
    
    // MARK: - Associated Types
    
    /// Type with level of ordering necessary to construct a `RelativeNamedInterval`.
    associatedtype SpelledPitchType
    
    /// Type describing ordinality of an `AbsoluteNamedInterval`.
    associatedtype Ordinal: NamedIntervalOrdinal
    
    /// MARK: - Instance Properties

    /// Ordinal of a `NamedInterval`.
    var ordinal: Ordinal { get }
    
    /// Quality of a `NamedInterval`
    var quality: NamedIntervalQuality { get }
    
    /// Inverse of a `NamedInterval`.
    var inverse: Self { get }
    
    // MARK: - Initializers
    
    /// Create a `NamedInterval` with a given `quality` and `ordinal`.
    init(_ quality: NamedIntervalQuality, _ ordinal: Ordinal)
    
    
    // Instead, use `PitchType` associatedtype
    /// Create a `NamedInterval` with two `SpelledPitch` values.
    init(_ a: SpelledPitchType, _ b: SpelledPitchType)
}

/// - returns: `true` if the given `quality` and `ordinal` can be paired to create a valid
/// `NamedInterval`. Otherwise, `false`.
///
/// **Example:**
/// ```
/// areValid(.major, .third) // true
/// areValid(.augmented, .second) // true
/// areValid(.perfect, .fourth) // true
/// areValid(.perfect, .second) // false
/// areValid(.major, .second) // false
/// ```
public func areValid <O: NamedIntervalOrdinal> (_ quality: NamedIntervalQuality, _ ordinal: O) -> Bool
{
    
    if ordinal.isPerfect && quality.isPerfect || ordinal.isImperfect && quality.isImperfect {
        return true
    }
    
    return false
}

extension NamedInterval {
    
    // MARK: - `Equatable`
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return (
            lhs.ordinal == rhs.ordinal &&
            lhs.quality == rhs.quality &&
            lhs.quality.degree == rhs.quality.degree
        )
    }
}

extension NamedInterval {

    // MARK: - `Invertible`
    
    public var inverse: Self {
        return .init(quality.inverse, ordinal.inverse)
    }
}

// TEMP: Update Collections

// Immutable swap.
public func swapped <T, U> (_ a: T, _ b: U) -> (U, T) {
    return (b,a)
}

/// - returns: If the given `predicate` is `true`, a tuple of `(b, a, true)`
/// Otherwise, `(a, b, false)`
public func swapped <T> (_ a: T, _ b: T, if predicate: () -> Bool) -> (T, T, Bool) {
    return predicate() ? (b, a, true) : (a, b, false)
}

/// If the given predicate if `true`, the given `a` and `b` values are swapped in an `inout`
/// fasion, and `true` is returned. Otherwise, no `swap` takes place, and `false` is returned.
public func swap <T> (_ a: inout T, _ b: inout T, if predicate: () -> Bool) -> Bool {
    
    if predicate() {
        swap(&a,&b)
        return true
    }
    return false
}


/*
import ArithmeticTools
import Pitch

/**
 NamedInterval.
 
 **Example:**
 
 ```
 let perfectUnison = NamedInterval(.perfect, .unison)!
 let augmentedFifth = NamedInterval(.augmented, .fifth)!
 let doubleAugmentedSeventh = NamedInterval(.double, .augmented, .seventh)!
 let _ = NamedInterval(.major, .fourth) // nil
 ```
 
 - TODO: Create names for quarter-step and eighth-step modified intervals
 
 - TODO: Use actual specialized `Interval` and `IntervalClass` value types, as opposed to
    throwing anonymous `Float` values around.
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
            case .unison, .fourth, .fifth:
                return .perfect
            default:
                return .imperfect
            }
        }
    }
    
    /// `Quality` of a `NamedInterval`.
    ///
    /// - TODO: Add documentation!
    public struct Quality: OptionSet, CustomStringConvertible {
        
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
        
        fileprivate static let perfectSet: Quality = [diminished, perfect, augmented]
        fileprivate static let imperfectSet: Quality = [diminished, minor, major, augmented]
        
        // MARK: - Instance Properties
        
        /**
         Inverse of a `Quality`
         (e.g., `.major.inverse == .minor`, `.perfect.inverse == .perfect`, etc).
         
         - TODO: Make table of inverse `Quality` pairs.
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
         Create a `NamedInterval.Quality`.
         */
        public init(rawValue: Int) {
            self.rawValue = rawValue
            self.degree = .single
        }
        
        /**
         Create a `NamedInterval.Quality` with a degree.
         */
        fileprivate init(rawValue: Int, degree: Degree) {
            self.rawValue = rawValue
            self.degree = degree
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
         
         - TODO: Flesh out documentation.
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
                default: fatalError() // don't match `perfectSet` and `imperfectSet`
                }
            }
            return degree == .single ? quality : "\(degree) \(quality)"
        }
    }
    
    // MARK: - Type Methods
    
    /**
     - returns: `Quality` for the given `normalizedIntervalClass` value, and the given
     `ordinal` value.
     
     - FIXME: Explain wtf a `normalizedIntervalClass` is.
     - TODO: Find more elegant way to do this. This implementation & api exists only
     - TODO: Factor out duplication in multiply diminished / augmented cases
     - TODO: Handle bad values properly. Currently things can blow up in extreme cases. Test.
     */
    public static func quality(for normalizedIntervalClass: Float, ordinal: Ordinal)
        -> Quality
    {
        
        let diminished: Float = ordinal == .unison
            ? -0.5
            : ordinal.family == .perfect
                ? -1
                : -1.5
        
        let augmented: Float = ordinal == .unison
            ? 0.5
            : ordinal.family == .perfect
                ? 1
                : 1.5
        
        switch normalizedIntervalClass {
        case diminished:
            return Quality.diminished
        case augmented:
            return Quality.augmented
        case _ where normalizedIntervalClass < diminished:
            let degreeValue = Int(abs(normalizedIntervalClass - diminished - 1))
            let degree = Quality.Degree(rawValue: degreeValue)!
            return Quality.diminished[degree]!
        case -0.5:
            return Quality.minor
        case +0.0:
            return Quality.perfect
        case +0.5:
            return Quality.major
        case _ where normalizedIntervalClass > augmented:
            let degreeValue = Int(abs(normalizedIntervalClass - augmented + 1))
            let degree = Quality.Degree(rawValue: degreeValue)!
            return Quality.augmented[degree]!
        default:
            fatalError() // impossible
        }
    }
    
    // MARK: - Instance Properties
    
    /**
     Inverse of a `NamedInterval`.
     
     - TODO: Add examples to documentation.
     - TODO: Make table of inverse relationship pairs.
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
        
        guard quality.isValid(for: ordinal) else {
            return nil
        }
        
        self.quality = quality
        self.ordinal = ordinal
    }
    
    /**
     Create a `NamedInterval` with a `degree`, `quality`, and `ordinal`.
     
     - TODO: Add examples to documentation.
     */
    public init?(_ degree: Quality.Degree, _ quality: Quality, _ ordinal: Ordinal) {
        
        guard let quality = quality[degree] else {
            return nil
        }
        
        self.init(quality, ordinal)
    }

    /// Create a `NamedInterval` with two `SpelledPitch` values.
    ///
    /// - TODO: Perhaps make internal only, as it can crash with programmer error.
    public init(_ a: SpelledPitch, _ b: SpelledPitch) {
        
        let letterNameSteps = steps(a,b)
        
        print("letterNameSteps: \(letterNameSteps)")
        
        // Neutral interval class (for imperfect interval, give mean value of two vals)
        let ideal = neutralIntervalClass(steps: letterNameSteps)
        
        print("ideal: \(ideal)")
        
        let i = interval(a,b)
        
        print("interval: \(i)")
        
        // get difference, then normalize it around 0(?)
        let normalized = normalizedIntervalClass(i - ideal)
        
        print("normalized: \(normalized)")
        
        let intervalClass = adjustedIntervalClass(normalized, steps: letterNameSteps)
        
        print("adjusted interval class: \(intervalClass)")
        
        self.init(steps: letterNameSteps, intervalClass: intervalClass)!
    }

    /// Helper initializer that gathers the ordinal and quality from the given `steps` and
    /// `intervalClass`.
    public init?(steps: Int, intervalClass: Float) {
        
        print("init with steps: \(steps); interval class: \(intervalClass)")
        
        guard let ordinal = NamedInterval.Ordinal(rawValue: steps) else {
            return nil
        }
        
        print("ordinal: \(ordinal)")
        
        let quality = NamedInterval.quality(for: intervalClass, ordinal: ordinal)
        
        print("quality: \(quality)")
        
        self.init(quality, ordinal)
    }
    
    /// - warning: Not yet documented!
    public init(_ a: PitchSpelling, _ b: PitchSpelling) {
        let a = SpelledPitch(Pitch(noteNumber: a.pitchClass.noteNumber), a)
        let b = SpelledPitch(Pitch(noteNumber: b.pitchClass.noteNumber), b)
        self.init(a,b)
    }
}

/// - returns: Delta between letter name steps of two `SpelledPitch` values.
public func steps(_ a: SpelledPitch, _ b: SpelledPitch) -> Int {
    
    print("steps: \(a); \(b)")
    
    let diff = b.spelling.letterName.steps - a.spelling.letterName.steps
    return mod(diff, 7)
}
/**
 - returns: Delta between pitch noteNumber values
 
 - TODO: Return `Interval` rather than `Float`.
 */
public func interval(_ a: SpelledPitch, _ b: SpelledPitch) -> Float {
    return mod(b.pitch.noteNumber.value - a.pitch.noteNumber.value, 7)
}

/**
 - returns: The given `intervalClass`, enforcing positive values if there is a `unison`
 relationship.
 */
public func adjustedIntervalClass(_ intervalClass: Float, steps: Int) -> Float {
    return steps == 0 ? abs(intervalClass) : intervalClass
}

/**
 - returns: The given `normalizedInterval`, in `IntervalClass` form (mod 12),
 
 - TODO: Return `IntervalClass` instead of `Float`.
 */
public func normalizedIntervalClass(_ normalizedInterval: Float) -> Float {
    
    print("normalized interval: \(normalizedInterval)")
    let leveled = normalizedInterval + 6
    print("leveled: \(leveled)")
    let mod12 = mod(leveled, 12)
    print("mod12: \(mod12)")
    let deleveled = mod12 - 6
    print("deleveled: \(deleveled)")
    
    return deleveled
}

/// - returns: The ideal interval class for the given `steps`.
///
/// - TODO: Consider renaming to `platonic` or something.
/// - FIXME: Documentation.
public func neutralIntervalClass(steps: Int) -> Float {
    let steps = mod(steps, 4)
    var neutral: Float {
        switch steps {
        case 0: return 0
        case 1: return 1.5
        case 2: return 3.5
        case 3: return 5
        default: fatalError()
        }
    }
    return neutral
}

/*
extension NamedInterval: CustomStringConvertible {
    
    // MARK: - CustomStringConvertible
    
    /// Printed description.
    public var description: String {
        return "\(quality) \(ordinal)"
    }
}

extension NamedInterval: Equatable {
    
    // MARK: - `Equatable`

    /// - returns: `true` if `ordinal` and `quality` values are equivalent. Otherwise, `false`.
    public static func == (lhs: NamedInterval, rhs: NamedInterval) -> Bool {
        return (
            lhs.ordinal == rhs.ordinal &&
            lhs.quality == rhs.quality &&
            lhs.quality.degree == rhs.quality.degree
        )
    }
}
*/
*/
