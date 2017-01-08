//
//  NamedIntervalOrdinal.swift
//  PitchSpellingTools
//
//  Created by James Bean on 1/8/17.
//
//

public protocol NamedIntervalOrdinal: RawRepresentable, Invertible {
    
    // Set of `perfect` interval ordinals
    static var perfect: Self { get }
    
    // Set of `imperfect` interval ordinals
    static var imperfect: Self { get }
    
    static var unison: Self { get }
    static var second: Self { get }
    static var third: Self { get }
    static var fourth: Self { get }
}
