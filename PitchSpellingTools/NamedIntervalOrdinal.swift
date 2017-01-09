//
//  NamedIntervalOrdinal.swift
//  PitchSpellingTools
//
//  Created by James Bean on 1/8/17.
//
//

public protocol NamedIntervalOrdinal: RawRepresentable, Equatable, Invertible {
    
    // Set of `perfect` interval ordinals
    static var perfects: Self { get }
    
    // Set of `imperfect` interval ordinals
    static var imperfects: Self { get }
    
    // Whether or not this ordinal belongs to the `perfects` class.
    var isPerfect: Bool { get }
    
    // Whether or not this ordinal belongs to the `imperfects` class.
    var isImperfect: Bool { get }
}
