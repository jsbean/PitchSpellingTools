//
//  OrderedPitchSet.swift
//  Pitch
//
//  Created by James Bean on 5/17/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import Foundation

/**
 Ordered collection of pitches.
 
 - TODO: `var ordered`
 - TODO: `func partition(_)`
 - TODO: `var inverse`
 - TODO: `var retrograde`
 - TODO: `var retrogradeInverse`
 */
public struct OrderedPitchSet: SequenceType {
    
    private var pitches: [Pitch]
    
    public init(pitches: Pitch...) {
        self.pitches = pitches
    }
    
    public init(pitches: [Pitch]) {
        self.pitches = pitches
    }
    
    public init(pitchSet: PitchSet) {
        self.pitches = pitchSet.map { $0 }
    }
    
    public func generate() -> AnyGenerator<Pitch> {
        var generator = pitches.generate()
        return AnyGenerator { return generator.next() }
    }
}
