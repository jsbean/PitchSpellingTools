//
//  PitchSet.swift
//  Pitch
//
//  Created by James Bean on 3/17/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import ArrayTools

/**
 Unordered collection of pitches.
 
 - TODO: `var pitches`
 - TODO: `var dyads`
 - TODO: `var class set`
 */
public struct PitchSet: SequenceType {
    
    private var pitches: Set<Pitch>
    
    public var pitchClassSet: Set<PitchClass> {
        return Set(pitches.lazy.map { $0.pitchClass })
    }
    
    public var dyads: [Dyad] {
        var result: [Dyad] = []
        var pitchesArray = Array(pitches)
        for a in 0 ..< pitchesArray.count {
            for b in a + 1 ..< pitchesArray.count {
                result.append(Dyad(pitchesArray[a], pitchesArray[b]))
            }
        }
        return result
    }
    
    public init(pitches: Pitch...) {
        self.pitches = Set(pitches)
    }
    
    public init(pitches: Set<Pitch>) {
        self.pitches = pitches
    }
    
    public init(pitches: [Pitch]) {
        self.pitches = Set(pitches)
    }
    
    public init(orderedPitchSet: OrderedPitchSet) {
        self.pitches = Set(orderedPitchSet.map { $0} )
    }
    
    public func generate() -> AnyGenerator<Pitch> {
        var generator = pitches.generate()
        return AnyGenerator { return generator.next() }
    }
}
