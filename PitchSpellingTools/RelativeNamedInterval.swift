//
//  RelativeNamedInterval.swift
//  PitchSpellingTools
//
//  Created by James Bean on 1/8/17.
//
//

import ArithmeticTools

/// Named intervals assuming no order between `SpelledPitch` values.
public struct RelativeNamedInterval: NamedInterval {
    
    // MARK: - Nested Types
    
    /// Ordinal of a `RelativeNamedInterval`
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
    public let quality: NamedIntervalQuality
    
    // MARK: - Initializers
    
    /// Create a `RelativeNamedInterval` with a given `quality` and `ordinal`.
    ///
    /// **Example:**
    /// ```Swift
    /// let minorSecond = RelativeNamedInterval(.minor, .second)
    /// let augmentedSixth = RelativeNamedInterval(.relative, .sixth)
    /// ```
    public init(_ quality: NamedIntervalQuality, _ ordinal: Ordinal) {
        self.quality = quality
        self.ordinal = ordinal
    }
}
