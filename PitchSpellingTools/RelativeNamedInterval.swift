//
//  RelativeNamedInterval.swift
//  PitchSpellingTools
//
//  Created by James Bean on 1/8/17.
//
//

import ArithmeticTools
import Pitch

/// Named intervals between two `SpelledPitch` values that does not honor order between
/// `SpelledPitch` values.
public struct RelativeNamedInterval: NamedInterval {
    
    // MARK: - Associated Types
    
    /// `PitchType` with level of ordering necessary to construct a `RelativeNamedInterval`.
    public typealias PitchType = PitchClass
    
    /// Type describing the quality of a `NamedInterval`-conforming type.
    public typealias Quality = NamedIntervalQuality
    
    // MARK: - Nested Types
    
    /// Type describing ordinality of a `RelativeNamedInterval`.
    public struct Ordinal: OptionSet, NamedIntervalOrdinal {
        
        // MARK: - Instance Properties
        
        /// Raw value.
        public let rawValue: Int
        
        // MARK: - Cases
        
        // MARK: Ordinal classes
        
        /// Set of `perfect` interval ordinals (`unison`, `fourth`)
        public static let perfects: Ordinal = [unison, fourth]
        
        /// Set of `imperfect` interval ordinals (`second`, `third`)
        public static var imperfects: Ordinal = [second, third]
        
        // MARK: Ordinal instances
        
        /// Unison.
        public static var unison = Ordinal(rawValue: 1 << 0)
        
        /// Second.
        public static var second = Ordinal(rawValue: 1 << 1)
        
        /// Third.
        public static var third = Ordinal(rawValue: 1 << 2)
        
        /// Fourth.
        public static var fourth = Ordinal(rawValue: 1 << 3)
        
        // MARK: - Initializers
        
        /// Create a `RelativeNamedInterval` with a given `rawValue`.
        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
        
        // MARK: - Instance Properties
        
        /// - returns: The inverse of an `Ordinal`.
        public var inverse: Ordinal {
            return Ordinal(rawValue: 1 << invert(powerOfTwo: rawValue, within: 4))
        }
        
        /// - returns: `true` if an `Ordinal` belongs to the `perfects` class. Otherwise,
        /// `false`.
        public var isPerfect: Bool {
            return Ordinal.perfects.contains(self)
        }
        
        /// - returns: `true` if an `Ordinal` belongs to the `imperfects` class. Otherwise, 
        /// `false`.
        public var isImperfect: Bool {
            return Ordinal.imperfects.contains(self)
        }
    }
    
    // MARK: - Instance Properties
    
    /// Ordinal value of a `RelativeNamedInterval` (`unison`, `second`, `third`, `fourth`).
    public let ordinal: Ordinal
    
    /// Quality value of a `RelativeNamedInterval`
    /// (`diminished`, `minor`, `perfect`, `major`, `augmented`).
    public let quality: Quality
    
    // MARK: - Initializers
    
    /// Create a `RelativeNamedInterval` with a given `quality` and `ordinal`.
    ///
    /// **Example:**
    /// ```Swift
    /// let minorSecond = RelativeNamedInterval(.minor, .second)
    /// let augmentedSixth = RelativeNamedInterval(.relative, .sixth)
    /// ```
    public init(_ quality: Quality, _ ordinal: Ordinal) {
        
        guard areValid(quality, ordinal) else {
            fatalError("Cannot create an RelativeNamedInterval with \(quality) and \(ordinal)")
        }
        
        self.quality = quality
        self.ordinal = ordinal
    }
    
    /// Create a `RelativeNamedInterval` with two `SpelledPitch` values.
    public init(_ a: SpelledPitchClass, _ b: SpelledPitchClass) {
        
        let (newA, newB, _) = swapped(a,b) { mod(steps(a,b), 7) > mod(steps(b,a), 7) }
        
        // 1. steps
        let intervalSteps = steps(newA, newB)
        
        // 2. steps -> neutral interval class
        let neutral = neutralIntervalClass(steps: intervalSteps)
        
        // 3. interval = return mod(b.pitch.noteNumber.value - a.pitch.noteNumber.value, 7)
        
        
        // 4. diff (interval - neutral interval class)
        // 5. diff -> normalized
        //      - print("normalized interval: \(normalizedInterval)")
        //        let leveled = normalizedInterval + 6
        //        let mod12 = mod(leveled, 12)
        //        let deleveled = mod12 - 6
        // 6. enforce positive values if unison
        //      - return steps == 0 ? abs(intervalClass) : intervalClass
        //
        
        print("steps: \(intervalSteps)")
        print("neutral: \(neutral)")
        self.init(.perfect, .unison)
    }
}

public func neutralIntervalClass(steps: Int) -> Float {
    
    assert(steps < 4)
    
    let steps = steps
    
    var neutral: Float {
        switch steps {
            
        // unison
        case 0:
            return 0
        
        // second
        case 1:
            return 1.5
            
        // third
        case 2:
            return 3.5
            
        // fourth
        case 3:
            return 5
            
        // impossible
        default:
            fatalError()
        }
    }
    return neutral
}

/// Wraps around 7
fileprivate func steps(_ a: SpelledPitchClass, _ b: SpelledPitchClass) -> Int {
    return mod(b.spelling.letterName.steps - a.spelling.letterName.steps, 7)
}

//private func swappedIfNecessary <C: Comparable(_ a: C, _ b: C)
//    -> (C, C, Bool)
//{
//    
//    return swapped(a,b) {
//        mod(b.spelling.letterName.steps - a.spelling.letterName.steps, 7) >
//        mod(a.spelling.letterName.steps - b.spelling.letterName.steps, 7)
//    }
//}
