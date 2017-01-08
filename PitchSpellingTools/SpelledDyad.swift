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
    
    /// Lower of the two `SpelledPitch` values.
    public let lower: SpelledPitch
    
    /// Higher of the two `SpelledPitch` values.
    public let higher: SpelledPitch
    
    /**
     `NamedInterval` of a `SpelledDyad`.
     
     **Example:**
     
     ```
     let c = SpelledPitch(60, PitchSpelling(.c))
     let eflat = SpelledPitch(63, PitchSpelling(.e, .flat))
     let dyad = SpelledDyad(c, eflat)
     // dyad.namedInterval == LetterName(.minor, .third)
     ```
     
     - TODO: Add examples to documentation.
     - TODO: Use RelativeNamedInterval
     */
    public var namedInterval: AbsoluteNamedInterval {
        fatalError()
        
        
        
//        let (a, b, needsInversion) = swappedIfNecessary(self.lower, self.higher)
//        let interval = NamedInterval(a,b)
//        return needsInversion ? interval.inverse : interval
    }
    
    // MARK: - Initializers
    
    /**
     Create a `SpelledDyad` with two `SpelledPitch` values.
     */
    public init(_ lower: SpelledPitch, _ higher: SpelledPitch) {
        let (lower, higher, _) = swapped(lower, higher) { lower > higher }
        self.lower = lower
        self.higher = higher
    }
}


private func swappedIfNecessary(_ a: SpelledPitch, _ b: SpelledPitch)
    -> (SpelledPitch, SpelledPitch, Bool)
{

    return swapped(a,b) {
        mod(b.spelling.letterName.steps - a.spelling.letterName.steps, 7) >
        mod(a.spelling.letterName.steps - b.spelling.letterName.steps, 7)
    }
}

/**
 Reorders the values `a` and `b` if the given `constraint` returns `true`.
 
 - returns: 3-tuple of the two values and a `Bool` indicating whether or not the values were
 swapped.
 
 - TODO: Move this into a more general library.
 */
public func swapped<A>(_ a: A, _ b: A, if constraint: () -> Bool) -> (A, A, Bool) {
    return constraint() ? (b, a, true) : (a, b, false)
}
