//
//  NamedIntervalQuality.swift
//  PitchSpellingTools
//
//  Created by James Bean on 1/8/17.
//
//

public struct NamedIntervalQuality: OptionSet, Invertible {
    
    // MARK: - Nested Types
    
    public enum Degree: Int {
        case single = 1
        case double = 2
    }
    
    // MARK: - Instance Properties
    
    /// Raw value.
    public let rawValue: Int
    
    // MARK: - Initializers
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    // MARK: - Cases
    
    static let diminished = NamedIntervalQuality(rawValue: 1 << 0)
    static let minor = NamedIntervalQuality(rawValue: 1 << 1)
    static let perfect = NamedIntervalQuality(rawValue: 1 << 2)
    static let major = NamedIntervalQuality(rawValue: 1 << 3)
    static let augmented = NamedIntervalQuality(rawValue: 1 << 4)
    
    static let perfectClass: NamedIntervalQuality = [diminished, perfect, augmented]
    static let imperfectClass: NamedIntervalQuality = [diminished, minor, major, augmented]
    
    public var inverse: NamedIntervalQuality {
        return NamedIntervalQuality.major
    }
}
