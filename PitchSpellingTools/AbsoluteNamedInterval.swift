//
//  AbsoluteNamedInterval.swift
//  PitchSpellingTools
//
//  Created by James Bean on 1/8/17.
//
//

import ArithmeticTools

public struct AbsoluteNamedInterval: NamedInterval {
    
    // MARK: - Associated Types
    
    public typealias Quality = NamedIntervalQuality
    
    // MARK: - Nested Types
    
    public struct Ordinal: OptionSet, NamedIntervalOrdinal {
        
        // MARK: - Instance Properties
        
        /// Raw value.
        public let rawValue: Int
        
        // MARK: - Cases
        
        // Set of `perfect` interval ordinals
        public static let perfects: Ordinal = [unison, fourth, fifth]
        
        // Set of `imperfect` interval ordinals
        public static var imperfects: Ordinal = [second, third, sixth, seventh]
        
        public static var unison = Ordinal(rawValue: 1 << 0)
        public static var second = Ordinal(rawValue: 1 << 1)
        public static var third = Ordinal(rawValue: 1 << 2)
        public static var fourth = Ordinal(rawValue: 1 << 3)
        public static var fifth = Ordinal(rawValue: 1 << 4)
        public static var sixth = Ordinal(rawValue: 1 << 5)
        public static var seventh = Ordinal(rawValue: 1 << 6)
        
        // MARK: - Initializers
        
        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
        
        // MARK: - Instance Properties
        
        public var inverse: Ordinal {
            return Ordinal(rawValue: 1 << invert(powerOfTwo: rawValue, within: 7))
        }
        
        public var isPerfect: Bool {
            return Ordinal.perfects.contains(self)
        }
        
        public var isImperfect: Bool {
            return Ordinal.imperfects.contains(self)
        }
    }
    
    // MARK: - Instance Properties
    
    public let ordinal: Ordinal
    public let quality: Quality
    
    public init(_ quality: NamedIntervalQuality, _ ordinal: Ordinal) {
        
        // can't have major (perfect) interval class types
        
        guard AbsoluteNamedInterval.areValid(quality, ordinal) else {
            fatalError()
        }
        
        self.quality = quality
        self.ordinal = ordinal
    }
    
    public static func areValid(_ quality: Quality, _ ordinal: Ordinal) -> Bool {
        
        if
            (ordinal.isPerfect && quality.isPerfect) ||
            (ordinal.isImperfect && quality.isImperfect)
        {
            return true
        }
        
        return false
    }
}
