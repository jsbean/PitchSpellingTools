//
//  AbsoluteNamedInterval.swift
//  PitchSpellingTools
//
//  Created by James Bean on 1/8/17.
//
//

import Foundation

public struct AbsoluteNamedInterval: NamedInterval {
    
    public init(_ quality: NamedIntervalQuality, _ ordinal: Ordinal) {
        fatalError()
    }

    
    public struct Ordinal: OptionSet, NamedIntervalOrdinal {
        
        // MARK: - Instance Properties
        
        /// Raw value.
        public let rawValue: Int
        
        // MARK: - Cases
        
        // Set of `perfect` interval ordinals
        public static let perfect: Ordinal = [unison, fourth, fifth]
        
        // Set of `imperfect` interval ordinals
        public static var imperfect: Ordinal = [second, third, sixth, seventh]
        
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
            fatalError()
        }
    }
    
    // MARK: - Instance Properties
    
    public let ordinal: Ordinal
    public let quality: NamedIntervalQuality
    
    
}
