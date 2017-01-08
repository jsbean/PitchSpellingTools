//
//  RelativeNamedInterval.swift
//  PitchSpellingTools
//
//  Created by James Bean on 1/8/17.
//
//

public struct RelativeNamedInterval: NamedInterval {
    
    public struct Ordinal: OptionSet, NamedIntervalOrdinal {
        
        // MARK: - Instance Properties
        
        /// Raw value.
        public let rawValue: Int
        
        // MARK: - Cases
        
        // Set of `perfect` interval ordinals
        public static let perfect: Ordinal = [unison, fourth]
        
        // Set of `imperfect` interval ordinals
        public static var imperfect: Ordinal = [second, third]
        
        public static var unison = Ordinal(rawValue: 1 << 0)
        public static var second = Ordinal(rawValue: 1 << 1)
        public static var third = Ordinal(rawValue: 1 << 2)
        public static var fourth = Ordinal(rawValue: 1 << 3)
        
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
    
    // MARK: - Initializers
    
    public init(_ quality: NamedIntervalQuality, _ ordinal: Ordinal) {
        self.quality = quality
        self.ordinal = ordinal
    }
}
