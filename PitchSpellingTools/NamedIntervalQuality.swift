//
//  NamedIntervalQuality.swift
//  PitchSpellingTools
//
//  Created by James Bean on 1/8/17.
//
//

import ArithmeticTools

public struct NamedIntervalQuality: OptionSet, Invertible {
    
    // MARK: - Nested Types
    
    public enum Degree: Int {
        case single = 1
        case double = 2
    }
    
    // MARK: - Cases
    
    public static let diminished = NamedIntervalQuality(rawValue: 1 << 0)
    public static let minor = NamedIntervalQuality(rawValue: 1 << 1)
    public static let perfect = NamedIntervalQuality(rawValue: 1 << 2)
    public static let major = NamedIntervalQuality(rawValue: 1 << 3)
    public static let augmented = NamedIntervalQuality(rawValue: 1 << 4)
    
    public static let perfectClass: NamedIntervalQuality = [
        diminished,
        perfect,
        augmented
    ]
    
    public static let imperfectClass: NamedIntervalQuality = [
        diminished,
        minor,
        major,
        augmented
    ]
    
    // MARK: - Instance Properties
    
    /// Raw value.
    public let rawValue: Int

    /// Degree (single)
    public let degree: Degree
    
    // MARK: - Initializers
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
        self.degree = .single
    }
    
    public init(rawValue: Int, degree: Degree) {
        self.rawValue = rawValue
        self.degree = degree
    }
    
    // MARK: - Subscripts
    
    public subscript(degree: Degree) -> NamedIntervalQuality? {
        switch (degree, self) {
        case
        (.single, _),
        (_, NamedIntervalQuality.diminished),
        (_, NamedIntervalQuality.augmented):
            return NamedIntervalQuality(rawValue: rawValue, degree: degree)
        default:
            return nil
        }
    }

    public var inverse: NamedIntervalQuality {
        return NamedIntervalQuality(rawValue: 1 << invert(powerOfTwo: rawValue, within: 4))
    }
}

