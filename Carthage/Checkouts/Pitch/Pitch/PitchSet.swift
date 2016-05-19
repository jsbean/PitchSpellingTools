//
//  PitchSet.swift
//  Pitch
//
//  Created by James Bean on 3/17/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import ArrayTools

/**
 Unordered collection of unique pitches.
 */
public struct PitchSet: SequenceType {
    
    private var pitches: Set<Pitch>
    
    // MARK: - Instance Properties
    
    /**
     Set of `PitchClass` representations of `PitchSet`.
 
     **Example:**
     
     ```
     let pitchSet: PitchSet = [Pitch(noteNumber: 63.5), Pitch(noteNumber: 69.25)]
     pitchSet.pitchClassSet // => [3.5, 9.25]
     ```
     */
    public var pitchClassSet: Set<PitchClass> {
        return Set(pitches.lazy.map { $0.pitchClass })
    }
    
    /** 
     All unique dyads that comprise a `PitchSet`.
     
     In the case that there are less than two `Pitch` objects in a `PitchSet`, 
     the `dyads` property is an empty array.
 
     **Example:**
     
     ```
     let triad: PitchSet = [
        Pitch(noteNumber: 60), 
        Pitch(noteNumber: 61), 
        Pitch(noteNumber: 62)
     ]
     
     triad.dyads // =>
     //    [
     //       Dyad(Pitch(noteNumber: 60), Pitch(noteNumber: 61)),
     //       Dyad(Pitch(noteNumber: 60), Pitch(noteNumber: 62)),
     //       Dyad(Pitch(noteNumber: 61), Pitch(noteNumber: 62))
     //    ]
     ```
     */
    public var dyads: [Dyad] {
        
        var pitchesArray = Array(pitches)
        
        guard pitchesArray.count >= 2 else { return [] }
        
        var result: [Dyad] = []
        for a in 0 ..< pitchesArray.count - 1 {
            for b in a + 1 ..< pitchesArray.count {
                result.append(Dyad(pitchesArray[a], pitchesArray[b]))
            }
        }
        return result
    }
    
    // MARK: - Initializers

    /// Create a `PitchSet` variadically with 0..n `Pitch` objects.
    public init(_ pitches: Pitch...) {
        self.pitches = Set(pitches)
    }
    
    /// Create a `PitchSet` with an `Array` of `Pitch` objects.
    public init(_ pitches: [Pitch]) {
        self.pitches = Set(pitches)
    }
    
    /// Create a `PitchSet` with a `Set` of `Pitch` objects.
    public init(pitches: Set<Pitch>) {
        self.pitches = pitches
    }
    
    /// Create a `PitchSet` with an `OrderedPitchSet`.
    public init(orderedPitchSet: OrderedPitchSet) {
        self.pitches = Set(orderedPitchSet.map { $0} )
    }
    
    /// Generate `Pitches` for iteration.
    public func generate() -> AnyGenerator<Pitch> {
        var generator = pitches.generate()
        return AnyGenerator { return generator.next() }
    }
}

extension PitchSet: ArrayLiteralConvertible {
    
    // MARK: - ArrayLiteralConvertible
    
    /**
     Create a `PitchSet` with an `ArrayLiteral` of `Pitch` objects.
    
     **Example:**
     
     ```
     let pitchSet: PitchSet = [Pitch(noteNumber: 60), Pitch(noteNumber: 67)]
     ```
     
     */
    public init(arrayLiteral pitches: Pitch...) {
        self.pitches = Set(pitches)
    }
}
