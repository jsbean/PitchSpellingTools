//
//  SpelledDyad.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/12/16.
//
//

import Foundation
import ArithmeticTools

/**
 Dyad of `SpelledPitch` values.
 */
public struct SpelledDyad {
    
    // MARK: - Instance Properties
    
    /// Higher of the two `Pitch` values.
    public let higher: SpelledPitch
    
    /// Lower of the two `Pitch` values.
    public let lower: SpelledPitch
    
    // MARK: - Initializers
    
    /**
     Create a `SpelledDyad` with two `Pitch` values.
     */
    public init(_ lower: SpelledPitch, _ higher: SpelledPitch) {
        let (lower, higher, _) = swapped(lower, higher) { lower > higher }
        self.lower = lower
        self.higher = higher
    }
    
    /**
     `NamedInterval` of a `SpelledDyad`.
     
     - TOOD: Add examples to documentation.
    */
    public var namedInterval: NamedInterval {
        let (a, b, needsInversion) = swappedIfNecessary(self.lower, self.higher)
        let interval = NamedInterval(a,b)
        return needsInversion ? interval.inverse : interval
    }
}


private func swappedIfNecessary(a: SpelledPitch, _ b: SpelledPitch)
    -> (SpelledPitch, SpelledPitch, Bool)
{
    return swapped(a,b) {
        Int.mod(b.spelling.letterName.steps - a.spelling.letterName.steps, 7) >
        Int.mod(a.spelling.letterName.steps - b.spelling.letterName.steps, 7)
    }
}

/**
 Reorders the values `a` and `b` if the given `constraint` returns `true`.
 
 - returns: 3-tuple of the two values and a `Bool` indicating whether or not the values were
 swapped.
 
 - TODO: Move this into a more general library.
 */
public func swapped<A>(a: A, _ b: A, if constraint: () -> Bool) -> (A, A, Bool) {
    return constraint() ? (b, a, true) : (a, b, false)
}
