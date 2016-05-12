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
    
    public init(higher: SpelledPitch, lower: SpelledPitch) {
        self.higher = higher
        self.lower = lower
    }
}