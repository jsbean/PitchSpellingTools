//
//  PitchSet.swift
//  Pitch
//
//  Created by James Bean on 3/17/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import ArrayTools

/**
 Unordered collection of unique `Pitch` values.
 */
public struct PitchSet: PitchSequenceType {
    
    private let pitches: Set<Pitch>
    
    // MARK: - Instance Properties
    
    /// Iterable sequence of `Pitch` values contained herein.
    public var sequence: AnySequence<Pitch> { return AnySequence(pitches) }
    
    /// - returns: `true` if there are no `Pitch` objects herein. Otherwsie `false`.
    public var isEmpty: Bool { return Array(sequence).count == 0 }
    
    /// - returns: `true` if there is one `Pitch` object herein. Otherwsie `false`.
    public var isMonadic: Bool { return Array(sequence).count == 1 }
    
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
     
     triad.dyads == [
        Dyad(Pitch(noteNumber: 60), Pitch(noteNumber: 61)),
        Dyad(Pitch(noteNumber: 60), Pitch(noteNumber: 62)),
        Dyad(Pitch(noteNumber: 61), Pitch(noteNumber: 62))
     ]
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

    /**
     Create a `PitchSet` with `SequenceType` containing `Pitch` values.
     */
    public init<S: SequenceType where S.Generator.Element == Pitch>(sequence: S) {
        self.pitches = Set(sequence)
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
