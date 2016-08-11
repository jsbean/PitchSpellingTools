//
//  SpelledDyad.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/12/16.
//
//

import Foundation

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
        let (lower, higher, _) = swap(lower, higher) { lower > higher }
        self.lower = lower
        self.higher = higher
    }
    
    /**
     `NamedInterval` of a `SpelledDyad`.
     
     - TOOD: Add examples to documentation.
     - TODO: Wrap up subprocesses into own private methods
    */
    public var namedInterval: NamedInterval {
        
        let (a, b, needsInversion) = swapIfNecessary(lower, higher)
        let steps = Int.mod(b.spelling.letterName.steps - a.spelling.letterName.steps, 7)
        let idealInterval = neutralIntervalClass(from: steps)
        
        let normalizedIntervalClass = (
            b.pitch.noteNumber.value - a.pitch.noteNumber.value - idealInterval
        )
        
        // wrap in method
        var intervalClass = Float.mod(normalizedIntervalClass + 6.0, 12.0) - 6.0
        
        // manage unison
        if steps == 0 { intervalClass = abs(intervalClass) }
        
        let ordinal = NamedInterval.Ordinal(rawValue: steps)!
        let intervalQuality = NamedInterval.quality(for: intervalClass, ordinal: ordinal)
        let namedInterval = NamedInterval(intervalQuality, ordinal)!
        return needsInversion ? namedInterval.inverse : namedInterval
    }
    
    /**
     -  TODO: Soldify naming / concept
     */
    private func neutralIntervalClass(from steps: Int) -> Float {
        switch steps {
        case 0: return 0
        case 1: return 1.5
        case 2: return 3.5
        case 3: return 5
        default: fatalError()
        }
    }
}

private func swapIfNecessary(a: SpelledPitch, _ b: SpelledPitch)
    -> (SpelledPitch, SpelledPitch, Bool)
{
    return swap(a,b) {
        return (
            Int.mod(b.spelling.letterName.steps - a.spelling.letterName.steps, 7) >
            Int.mod(a.spelling.letterName.steps - b.spelling.letterName.steps, 7)
        )
    }
}

/**
 Reorders the values `a` and `b` if the given `constraint` returns `true`.
 
 - returns: 3-tuple of the two values and a `bool` indicated if the values were swapped.
 
 - TODO: Move this into a more general library.
 */
public func swap<A>(a: A, _ b: A, if constraint: () -> Bool) -> (A, A, Bool) {
    return constraint() ? (b, a, true) : (a, b, false)
}
