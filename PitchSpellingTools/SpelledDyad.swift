//
//  SpelledDyad.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/12/16.
//
//

import Foundation
import ArithmeticTools


/// Dyad of `SpelledPitch` values.
public struct SpelledDyad {
    
    // MARK: - Instance Properties
    
    /// Lower of the two `SpelledPitch` values.
    public let lower: SpelledPitch
    
    /// Higher of the two `SpelledPitch` values.
    public let higher: SpelledPitch
    
    /// - returns: Relative named interval, which does not ordering of `SpelledPitch` values
    /// contained herein.
    public var relativeInterval: RelativeNamedInterval {
        fatalError()
    }
    
    /// - returns: Absolute named interval, which honors ordering of `SpelledPitch` values
    /// contained herein.
    public var absoluteInterval: AbsoluteNamedInterval {
        fatalError()
    }
    
    // MARK: - Initializers
    
    /// Create a `SpelledDyad` with two `SpelledPitch` values.
    public init(_ lower: SpelledPitch, _ higher: SpelledPitch) {
        let (lower, higher, _) = swapped(lower, higher) { lower > higher }
        self.lower = lower
        self.higher = higher
    }
}
