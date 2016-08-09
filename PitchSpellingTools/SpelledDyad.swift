//
//  SpelledDyad.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/12/16.
//
//

import Foundation

public struct SpelledDyad {
    
    public let higher: SpelledPitch
    public let lower: SpelledPitch
    
    public init(_ lower: SpelledPitch, _ higher: SpelledPitch) {
        self.lower = lower
        self.higher = higher
    }
    
    public var intervalQuality: IntervalQualityKind {
        
        let (a, b, needsInversion) = swapIfNecessary(lower, higher)
        let steps = Int.mod(b.spelling.letterName.steps - a.spelling.letterName.steps, 7)
        let idealInterval = idealIntervalClass(from: steps)
        
        let normalizedIntervalClass = (
            b.pitch.noteNumber.value - a.pitch.noteNumber.value - idealInterval
        )
        
        // wrap in method
        var intervalClass = Float.mod(normalizedIntervalClass + 6.0, 12.0) - 6.0
        
        // manage unison
        if steps == 0 { intervalClass = abs(intervalClass) }
        let ordinal = IntervalQuality.ordinal(withAmountOfSteps: steps)
        let kind = ordinal._kind(intervalClass: intervalClass)
        return needsInversion ? ordinal.inverse._kind(intervalClass: intervalClass * -1) : kind
    }
    
    private func idealIntervalClass(from steps: Int) -> Float {
        switch steps {
        case 0: return 0
        case 1: return 1.5
        case 2: return 3.5
        case 3: return 5
        default: fatalError()
        }
    }
}

func swapIfNecessary(a: SpelledPitch, _ b: SpelledPitch)
    -> (SpelledPitch, SpelledPitch, Bool)
{
    return swap(a,b) {
        return (
            Int.mod(b.spelling.letterName.steps - a.spelling.letterName.steps, 7) >
            Int.mod(a.spelling.letterName.steps - b.spelling.letterName.steps, 7)
        )
    }
}

// TODO: put in a more generic library (like ArrayTools) ?
public func swap<A>(a: A, _ b: A, if constraint: () -> Bool) -> (A, A, Bool) {
    return constraint() ? (b, a, true) : (a, b, false)
}
