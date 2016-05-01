//
//  SpelledPitchDyad.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/1/16.
//
//

import Foundation
import ArithmeticTools

public struct SpelledPitchDyad {
    
    public let lower: SpelledPitch
    public let higher: SpelledPitch
    
    public init(_ a: SpelledPitch, _ b: SpelledPitch) {
        let (lower, higher) = ordered(a,b)
        self.lower = lower
        self.higher = higher
    }
}